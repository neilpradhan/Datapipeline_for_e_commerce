output "dataset_id" {
  value = google_bigquery_dataset.ecommerce.dataset_id
}

output "orders_table_id" {
  value = google_bigquery_table.orders.table_id
}

output "inventory_table_id" {
  value = google_bigquery_table.inventory.table_id
}
