variable "region" {
  type = string
}

variable "account_ids" {
  type = map(string)
}

variable "stage" {
  type = string
}

variable "app_name" {
  type = string
}

variable "owner" {
  type = string
}

variable "root_zone_name" {
  type = string
}

#variable "email_subscribers" {
#  type = list(string)
#}

#variable "account_name" {
#  type = string
#}

#variable "threshold" {
#  type = map(string)
#}
