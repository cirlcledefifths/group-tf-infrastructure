module "infrastructure" {
  source = "../../../../../modules/infrastructure"

  certificates = {
    "preprod.cloud.metwork.com-wildcard-us-east-2-rsa"   = "arn:aws:acm:us-east-2:975050254173:certificate/acb6e05e-ab9e-4642-84f3-026e2a713983"
    "preprod.cloud.metwork.com-wildcard-us-east-2-ecdsa" = "arn:aws:acm:us-east-2:975050254173:certificate/961de68e-4c61-47b6-935c-33b31d3615ee"
  }
  short_name = "nonprod01"
  vpc_cidr   = "10.232.0.0/16"
}
