variable "projects" {
  type = list(string)
}

variable "default_apis" {
  type    = list(string)
  default = []
}

variable "additional_apis" {
  type    = map(list(string))
  default = {}
}

variable "environments" {
  type = map(string)
}

variable "billing_account" {
  type = string
}

variable "project_budget_amount" {
  type    = map(number)
  default = {}
}

variable "default_project_budget" {
  type = object({
    currency_code = optional(string)
    amount        = number
    threshold_rules = optional(list(object({
      threshold_percent = optional(number)
      spend_basis       = optional(string)
    })))
  })
  description = "default budget to apply per project"
}
