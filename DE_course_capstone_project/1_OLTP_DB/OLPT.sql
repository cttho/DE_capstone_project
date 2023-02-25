CREATE DATABASE sales;

CREATE TABLE sales.sales_data (
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    timestamp TIMESTAMP NOT NULL,
    PRIMARY KEY (product_id, customer_id)
);

CREATE INDEX index_name ON sales.sales_data (timestamp);