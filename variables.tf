variable "appenvironment" {
    description = "Mention the environment dev for development & anything other than dev to prod"
    type =string
    default = "dev"  
}
variable "altozedbusername" {
  description = "altoze db username"
  type = string
  sensitive = true
}
variable "altozedbpassword" {
  description = "altoze db password"
  type = string
  sensitive = true
}
variable "appname" {
  description = "application name"
  type = string
  default = "altoze"
}
variable "s3bucket" {
  description = "Backend S3 Bucket Name"
  type = string
}
variable "s3bucketkey" {
  description = "Backend S3 Bucket Key"
  type = string
  default = "altoze.tfstate"
}
variable "s3bucketregion" {
  description = "Backend S3 Bucket Key"
  type = string
  default = "us-east-1"
}