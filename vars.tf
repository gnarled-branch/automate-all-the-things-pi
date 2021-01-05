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
  default     = "chrisgallivan/automate-all-the-things-docker-pi:latest"
}

variable "host" {
  type = string
  default = "https://192.168.1.222:6443"
}

locals {
  client_certificate = base64decode("LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURFekNDQWZ1Z0F3SUJBZ0lJZitVWFBDTmhEYjR3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TURFeU1ERXdNRFV5TkRaYUZ3MHlNVEV5TURFd01EVXpNVE5hTURReApGekFWQmdOVkJBb1REbk41YzNSbGJUcHRZWE4wWlhKek1Sa3dGd1lEVlFRREV4QnJkV0psY201bGRHVnpMV0ZrCmJXbHVNSUlCSWpBTkJna3Foa2lHOXcwQkFRRUZBQU9DQVE4QU1JSUJDZ0tDQVFFQXJGU1EyN0k0cjlrOG00ZG8KOHkzdDlXekRHRUp3UlJmNDZjT0szNUdVZFlMUGtoYllCOXdTbGNhNkJTMDRtNjZWQkRRaFQxVk5jWmEzZk5sUAorbTVHMm5KM3dvL1lHNitTa0tnZlZPR0NwOFBjL2VHeEt0ZDRiNUE4UDZlSVhSZXVVd2oyd1hGNkxEYjhjRGF1Ck8yMFpmQ3phbWF2RGVhWUVXdTFiNUx4QVR4enVjREs1U3h5WjVDekp5dDNFTWdvSERqMmFlRk9tRkpCODRsdWwKNFlMeDlMK0lORjVEUHgrUk5qRGpsSmdvY2dlamhkamlWMlZnVEhSdVNiZGUvREZQNE84S1YrajZjQ3NVWDVTMgpCcTlFM3AyV3ViNE51RUsycHZ5TWpCQzQvc2VsUUxFdFJ0L1JIWU8zWEk0b2hoazZqUUV5c0M2d0lOZ3VxNGlECnpSb003d0lEQVFBQm8wZ3dSakFPQmdOVkhROEJBZjhFQkFNQ0JhQXdFd1lEVlIwbEJBd3dDZ1lJS3dZQkJRVUgKQXdJd0h3WURWUjBqQkJnd0ZvQVVmaDJkUm9PRDRURUtiR0ZXSVZFTWVpNUpoZ1F3RFFZSktvWklodmNOQVFFTApCUUFEZ2dFQkFOLzlPbjVwRFJDSXkwNmdXZGlFUFJFT1JhbEY0b29zQnFyalJjZUJzRGxDNmh3dmlPZ1FOYlBSCmdyT1FmeGFsaHp4WUlYRTZtK1BTWEFaRkxPaHQ5Qko2empNMXpRMmthOEhRd1dDOFRoVHlWRGVPTXByZDFjdjMKdWFJaGNxNW5pWnJMdGdUbkhBMnI1b0VLdC9sYk1yWC9zNTdDRUUvMUlPRlNJTGlyaVl2ZDlLT1RXbi9QZzhYQQpJR0FVZVBYY1BBZTRvek9HZ2pxYkF0K050bW9kenBrdGpBZGVZVUFlK3k0N0o5cVhzMGZyRGxDbmJXRTlHTm5CClZ4K3Y0SzBtK05ocVBnREpRYkcvZEdwaThtU2t0eE9ybGNpUWFYU3FOVkFVLzJPV1VuU3pSbW1rUUlndjJDT3gKWDYvTGtDQWlJaDUvNkl4K250Z0dlTXFxRDBsNjdmMD0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=")
  client_key = base64decode("LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcEFJQkFBS0NBUUVBckZTUTI3STRyOWs4bTRkbzh5M3Q5V3pER0VKd1JSZjQ2Y09LMzVHVWRZTFBraGJZCkI5d1NsY2E2QlMwNG02NlZCRFFoVDFWTmNaYTNmTmxQK201RzJuSjN3by9ZRzYrU2tLZ2ZWT0dDcDhQYy9lR3gKS3RkNGI1QThQNmVJWFJldVV3ajJ3WEY2TERiOGNEYXVPMjBaZkN6YW1hdkRlYVlFV3UxYjVMeEFUeHp1Y0RLNQpTeHlaNUN6Snl0M0VNZ29IRGoyYWVGT21GSkI4NGx1bDRZTHg5TCtJTkY1RFB4K1JOakRqbEpnb2NnZWpoZGppClYyVmdUSFJ1U2JkZS9ERlA0TzhLVitqNmNDc1VYNVMyQnE5RTNwMld1YjROdUVLMnB2eU1qQkM0L3NlbFFMRXQKUnQvUkhZTzNYSTRvaGhrNmpRRXlzQzZ3SU5ndXE0aUR6Um9NN3dJREFRQUJBb0lCQUhFb2puNVV4dmhoYzNURgpNOXNLKzhnK2hOVTNPeldEaWtVbHk5a0daUy9NbDdSY0g3cjVmWkt3RFpJOG9ZRkk0RDBFWmlNTDVuQ0NBVGFRCkUvNWp6MDY5LzNuWXJwVnZjcFJlY1VSeFdEUUZYdVd1LzRFY1A4OHlMUDIzYXNtR05VZjlDTnI1UXJvcDJSVnUKTW5aL0swN292UnBQT1dwMTQwSTV2aSt5bFovY1VZWXVtY2tSU2JEWlk3citiZ3huc1JlUm5nOFBlMjFBaFE1OQppYWJXNTVadVdGRTR5M3NoK1VVZzlUaXRONTBaU29pbGVlZDdxUlcvWFlJMGlWQTVNbTNSTEJCL1MzMEJiL01qCkVOMUpiSEtPSlNEemk0RGxmS0FwajNvOEo4VXBLaEpKd2xWK0YwN2lSczZjeEZ4OHpHTEhJZktxQTlkMElXYTEKTkJjdTE0RUNnWUVBeW5zZzB4em1SeFVkMkx6RktlQ2o2M25vcjl6aUQxYWt0aU1tektuaHhUTEN6THpnOUZXLwpLZDIzaTRVb29ZV2FNNE50S3haS3FFZnNVSFMreExaY3VCUVp6Qm85aXp5Tld3QWM3bDE0L0NGcFpRaFNCczgvClRjbUtWcmx0Tno1Wi9xT3JiaUQ4ek85SGtHeDhTRnYyb2JQbjlXRW9wWHBZbFZYMXZIcmtENkVDZ1lFQTJlRkwKb0ZnQWdabmt3dVBrL0NXT3ovTnkxRUp3MHhIeEkrd3pFeTRWblNKZXJqY25HQ0s1NGdiYTlpSXlEUEtoOUtITQo4SUw0enEranpuMVZWY3c0NjltMVlkUVlMYUhnbFRCaUZ6Uyt1aDkvZ2ZLUnJocW43cHVSZEpWdGloaVBXV3paCnBveGJweVhRWDdVcTRPZ2J6Mnk1KzdUcUk0Z0haNVhtWU1rY0VvOENnWUFGWEVNZk02bXBBaGNiTU13cmNxWUUKU3VMdEhQVGpJUkVWUFZMK29oUzNDc1A3ZFppaS8wNGpScHBnV0RNZUs1Sk1nTk00Qzh3SUxuZEVIZ01hNUJVSwpUb1hzVUZtR3dTQ2c0eHpnOXBxSVdqNFhEYVJXUjlCT04rS3dyeElFSDJOMGlWSzFoS3dNcE4wSkpzWVhpRSs4Ck1pNFc0ZTZZaXVlamRIWWYra1RsWVFLQmdRQ2JRbFZ1M0diMzg1ODFWY3A5OTVHT0ZCQTJ1MlhFc3R0Z1d0ZUcKaW1keWd1UnZSdlAvMmZjVjN3YTNNR1QwSHc1VDBkekZZcjlFSVpzYjhPb1hhcUVCU0RGZGxoTG9xWnJ0RlA1QgpSUi9JWjl1bjBTQUlyZ3dQRnlLT3JsRFJnSERlSzVmcGU4bHdFWjBzSm1CNHhrM1RBTXFEV0Vja3JMR0NHaXFCCnU2M2Fkd0tCZ1FDQ2M4MzBtSEpSeEVXTDZxMlRvbDJYMDVtb0hvZTltdnlZVEptQUpmbFA2ZlowRWwvbTFZZ3gKamZpZnZPbjUzNDdCbkFnbzJwTmMwUFUwZTNaK1krNk96U3hNTzRPUnhQbjRFaU9UM0hweXNhTGRvZ3pJZWRWYgpFbDhjdmJKTGxzWlVXbW1HZDY1KzFhUVRJc01jWHRFYzJOZDBsbkJyazZZV2FSaTBsNjJscUE9PQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQo=")
  cluster_ca_certificate = base64decode("LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM1ekNDQWMrZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJd01USXdNVEF3TlRJME5sb1hEVE13TVRFeU9UQXdOVEkwTmxvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBT1BHCjFmRjdoR3dJVUtRdmw1TWJqMm9naGRPSXJrSzlsZTI0clU5U2piL3JRK3NkMEhTRkpaNnlhbVRLN0hUcG1tRm0Kb3FnZkI0eXkxKzE3S0NoUzhwWk5YTUZZZktrYUgzaHBySTMwWUFhblFtK3NGU0Q3RnhJWXc4NFl3MkVIK2xtKwpKWkUza2oyQzI0VGNScXJRd0tpMUVlRTZxTFpXMW5FMlNRV3lRVlZQcExyT1N1ZmxmQUVwMWRRSkxiT3RWQ1FMClpIczZ4RDNiVCt1dkhTZGRLaEdqZmkvenlmRjF5a2p5bWFpTktqcUFZeEh1dHlnZHJ3UnpOZzV3Tkg3RmpQbGEKMlFoekhVZVJRRklZMVVtVE5MNDhIYXE5WnZqZUdLNWozdWdFdkdzTS9MZGMxam5GSW5Vd2grOVJqWGtLK1dEdApSRytTRHlDenQzbXk5bm9zck1zQ0F3RUFBYU5DTUVBd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZINGRuVWFEZytFeENteGhWaUZSREhvdVNZWUVNQTBHQ1NxR1NJYjMKRFFFQkN3VUFBNElCQVFCdVB0b1JIMTZtN2Q2enpOODhIclcwQ2laVnVwalhkZmEwNnB3UUZlVFYvYXA3ODdWSApMQjdzaGh0L2JrRFQxWDlmZWtCcE5JVkFodC9lOERyQjVsNXpIL2pRZHpQQktFU2xTTGwvbmRsMU1JQTBTSVV2CmJCcHlaWVVKZGF0NXV1VEd4SGNCZFQrc1c5R053cmZmZE9PRENTZ2NEcTE2d2ZONDdwRDBvRGdLTk1hUms4UG8KWlh0c0NHVnZCbUcrYnhzU3RISDRyK0ZTUW4xUWdoWUh4SGVqam9ZcW1XWDJkVEx4M0ZNa3ZWSDB3M3FiZ0lwSwovbGZnK3h3eFpWVzhXZGFRcVJhakJ2REdXRmxKRm1rclRwdTE2TGhqRk5KMEtEUE4vY3dJZFRoeElXTnhha1o0CjNMZExka1pQZjc5UldaSkp0S2RPV05kWEZadmR5UXk2VW4zNAotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==")  
}
