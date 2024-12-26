module "s3_static_website" {
  source      = "../../modules/s3-static-website"
  bucket_name = var.bucket_name
}

resource "aws_cloudfront_distribution" "cdn" {
  origin {
    # domain_name = module.s3_static_website.website_endpoint
    origin_id   = "S3-${module.s3_static_website.bucket_name}"
    domain_name = module.s3_static_website.domain_name
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-${module.s3_static_website.bucket_name}"

    # viewer_protocol_policy = "redirect-to-https"
    viewer_protocol_policy = "allow-all"
    min_ttl = 0
    default_ttl = 3600
    max_ttl = 86400

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    # acm_certificate_arn = var.acm_certificate_arn
    # ssl_support_method   = "sni-only"
    cloudfront_default_certificate = true
  }
}
