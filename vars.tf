variable "deployment_username" {

}

variable "deployment_password" {

}

variable "region" {
  default     = "us-east-2"
  description = "AWS region"
}

variable "app" {
  type        = string
  description = "Name of application"
  default     = "automate-all-the-things-pi"
}
variable "zone" {
  default = "us-east-2b"
}
variable "docker-image" {
  type        = string
  description = "name of the docker image to deploy"
  default     = "chrisgallivan/automate-all-the-things-docker:latest"
}
