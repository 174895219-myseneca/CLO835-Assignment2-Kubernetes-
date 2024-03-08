# Step 8 - Add variables
variable "instance_type" {
  default     = "t2.large"
  description = "Type of the instance"
  type        = string
}

# Step 8 - Add variables
variable "default_tags" {
  default = {
    "Name"  = "AugustineAntwi_Week8_assignment2"
    "Owner" = "CLO835"
    "App"   = "Docker"
  }
  type        = map(any)
  description = "Default tags to be applied to all AWS resources"
}

# Step 8 - Add variables
variable "prefix" {
  default     = "clo835-assignment2"
  type        = string
  description = "Name prefix"
}



