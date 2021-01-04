terraform {
 backend "s3" {
   bucket = "automate-all-the-things-pi-terraform-state"
   key = "global/s3/terraform.tfstate"
   region = "us-east-2"
   dynamodb_table = "automate-all-the-things-pi-terraform-locks"
   encrypt = true
   }
 }
