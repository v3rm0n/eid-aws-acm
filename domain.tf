resource "aws_api_gateway_domain_name" "demo" {
  domain_name              = local.domain_name
  regional_certificate_arn = aws_acm_certificate.cert.arn

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  mutual_tls_authentication {
    truststore_uri     = "s3://${aws_s3_object.truststore.bucket}/${aws_s3_object.truststore.key}"
    truststore_version = aws_s3_object.truststore.version_id
  }

  security_policy = "TLS_1_2"
}

resource "aws_s3_bucket" "truststore" {
  bucket = "demo-truststore-bucket"
}

resource "aws_s3_bucket_versioning" "truststore" {
  bucket = aws_s3_bucket.truststore.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "truststore" {
  bucket = aws_s3_bucket.truststore.id
  acl    = "private"
}

resource "aws_s3_object" "truststore" {
  bucket  = aws_s3_bucket.truststore.bucket
  key     = "truststore.pem"
  content = local.truststore
  etag    = md5(local.truststore)
}

resource "cloudflare_record" "demo_dns" {
  zone_id = data.cloudflare_zone.zone.id
  name    = var.subdomain
  value   = aws_api_gateway_domain_name.demo.regional_domain_name
  type    = "CNAME"
}