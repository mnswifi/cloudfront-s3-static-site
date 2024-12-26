output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.website_bucket.id
}

output "website_endpoint" {
  description = "The S3 website endpoint"
  value       = aws_s3_bucket_website_configuration.name.website_endpoint
}

output "domain_name" {
  description = "The domain name of the S3 website"	
  value       = aws_s3_bucket.website_bucket.bucket_regional_domain_name
}