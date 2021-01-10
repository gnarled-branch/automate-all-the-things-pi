terraform {
 backend "s3" {
   bucket = "automate-all-the-things-pi2-terraform-state"
   key = "dev/s3/terraform.tfstate"
   region = "us-east-2"
   dynamodb_table = "automate-all-the-things-pi2-terraform-locks"
   encrypt = true
   }
 }
