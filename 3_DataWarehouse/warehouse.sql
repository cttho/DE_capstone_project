CREATE DATABASE warehouse;

CREATE TABLE warehouse.softcartDimDate (
    dateid int NOT NULL,
    date date NOT NULL,
    year smallint NOT NULL,
    month smallint NOT NULL,
    monthname varchar(10) NOT NULL,
    day smallint NOT NULL,
    quarter smallint NOT NULL,
    quartername char(2) NOT NULL,
    weekday smallint NOT NULL,
    weekdayname varchar(10) NOT NULL,
    PRIMARY KEY (dateid)
);


CREATE TABLE warehouse.softcartDimCategory (
    categoryid int NOT NULL,
    categoryname varchar(15) NOT NULL,
    PRIMARY KEY(categoryid)
);

CREATE TABLE warehouse.softcartDimItem (
    itemid int NOT NULL,
    itemname varchar(35) NOT NULL,
    PRIMARY KEY(itemid)
);

CREATE TABLE warehouse.softcartDimCountry (
    countryid int NOT NULL,
    countryname varchar(35) NOT NULL,
    PRIMARY KEY(countryid)
);

CREATE TABLE warehouse.softcraftFactSales (
    orderid int NOT NULL,
    itemid int NOT NULL,
    categoryid int NOT NULL,
    countryid int NOT NULL,
    dateid int NOT NULL,
    price float NOT NULL,
    PRIMARY KEY (orderid)
);

# Design requirement relationships

ALTER TABLE warehouse.softcraftFactSales
ADD CONSTRAINT fk_fact_item
FOREIGN KEY (itemid)
REFERENCES warehouse.softcartDimItem(itemid);

ALTER TABLE warehouse.softcraftFactSales
ADD CONSTRAINT fk_fact_category
FOREIGN KEY (categoryid)
REFERENCES warehouse.softcartDimCategory(categoryid);

ALTER TABLE warehouse.softcraftFactSales
ADD CONSTRAINT fk_fact_country
FOREIGN KEY (countryid)
REFERENCES warehouse.softcartDimCountry(countryid);

ALTER TABLE warehouse.softcraftFactSales
ADD CONSTRAINT fk_fact_date
FOREIGN KEY (dateid)
REFERENCES warehouse.softcartDimDate(dateid);