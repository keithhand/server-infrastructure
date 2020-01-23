provider "kubernetes" {}

module "personal_webpage" {
  source = "./modules/nginx"
}