# deploy-web-aws-instance

Deploy a website on an AWS instance

# Terraform

## Variables

Define the following variables in variables.tf where CIDR is an IP and netmask

```
$ cat variables.tf 
variable "selfa" {
  description = "IP1"
  type        = string
  default     = "CIDR"
}
variable "selfb" {
  description = "IP2"
  type        = string
  default     = "CIDR"
}
variable "keyname" {
  description = "keyname"
  type        = string
  default     = "keynamehere"
}
variable "instance_name" {
  description = "instance name"
  type        = string
  default     = "web"
}
```

## Infrastructure

* AWS EC2 instance running nginx.

## Interface

* Describe current infrastructure

```
cd terraform
tf show
```
