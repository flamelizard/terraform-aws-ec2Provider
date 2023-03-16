variable "instance_type" {
  default = "t2.micro"
  type    = string
}

variable "ami_id" {
    # amazon linux 2
  default = "ami-005f9685cb30f234b"
  type    = string
}

variable "volume_gb" {
  default = 10
  type    = number
}
