variable "key_name" {
  description = "The name of the key pair"
  type        = string
}

variable "public_key_path" {
  description = "The path to the public key file"
  type        = string
  
}

variable "filename" {
  description = "The path where the private key will be saved"
  type        = string
  
}