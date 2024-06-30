variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "calm-cove-423918-t0"
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "dataset_id" {
  description = "The BigQuery dataset ID"
  type        = string
  default     = "Dema"
}

variable "location" {
  description = "The BigQuery dataset location"
  type        = string
  default     = "US"
}
