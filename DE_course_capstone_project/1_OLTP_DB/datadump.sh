#!/bin/bash

# Export all the rows in the "sales_data" table to a file named "sales_data.sql"
mysqldump --host=127.0.0.1 --port=3306 --user=root --password=123456 sales sales_data > sales_data.sql

echo "Exporting data completed successfully."