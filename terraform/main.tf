# Configure the Google Cloud provider
provider "google" {
  project = "calm-cove-423918-t0"
  region  = "us-central1"
  credentials = file("C:/Users/epranei/Downloads/calm-cove-423918-t0-ce8d5f6922f1.json")
}

# Create a BigQuery dataset
resource "google_bigquery_dataset" "ecommerce" {
  dataset_id = var.dataset_id
  location   = var.location
}

# Create the Orders table
resource "google_bigquery_table" "orders" {
  dataset_id = google_bigquery_dataset.ecommerce.dataset_id
  table_id   = "Orders"

  schema = <<EOF
[
  {
    "name": "orderId",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "productId",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "currency",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "quantity",
    "type": "INT64",
    "mode": "NULLABLE"
  },
  {
    "name": "shippingCost",
    "type": "FLOAT64",
    "mode": "NULLABLE"
  },
  {
    "name": "amount",
    "type": "FLOAT64",
    "mode": "NULLABLE"
  },
  {
    "name": "channel",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "channelGroup",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "campaign",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "dateTime",
    "type": "TIMESTAMP",
    "mode": "REQUIRED"
  }
]
EOF
}

# Create the Inventory table
resource "google_bigquery_table" "inventory" {
  dataset_id = google_bigquery_dataset.ecommerce.dataset_id
  table_id   = "Inventory"

  schema = <<EOF
[
  {
    "name": "productId",
    "type": "STRING",
    "mode": "REQUIRED"
  },
  {
    "name": "name",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "category",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "subCategory",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "quantity",
    "type": "INT64",
    "mode": "NULLABLE"
  },
  {
    "name": "startDate",
    "type": "TIMESTAMP",
    "mode": "REQUIRED"
  },
  {
    "name": "endDate",
    "type": "TIMESTAMP",
    "mode": "NULLABLE"
  },
  {
    "name": "isCurrent",
    "type": "BOOLEAN",
    "mode": "NULLABLE"
  }
]
EOF
}
