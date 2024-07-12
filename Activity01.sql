CREATE DATABASE Salesdb;

USE Salesdb;

CREATE TABLE productline(
	productLine VARCHAR(50) PRIMARY KEY,
    textDescription VARCHAR(4000),
    htmlDescription MEDIUMTEXT,
    image MEDIUMBLOB
);

CREATE TABLE products(
	productCode VARCHAR(15) PRIMARY KEY,
    productName VARCHAR(70) NOT NULL,
    productLine VARCHAR(50),
    CONSTRAINT fk_productLine
    FOREIGN KEY (productline)
	REFERENCES productline(productLine),
    productScale VARCHAR(10) NOT NULL,
    productVendor VARCHAR(50) NOT NULL,
    productDescription TEXT NOT NULL,
    quantityInStock SMALLINT NOT NULL,
    buyPrice DECIMAL(10, 2) NOT NULL,
    MSRP DECIMAL(10,2) NOT NULL
);

CREATE TABLE employees(
	employeeNumber INT PRIMARY KEY,
    lastName VARCHAR(50) NOT NULL,
    firstName VARCHAR(50) NOT NULL,
    extension VARCHAR(10) NOT NULL,
    email VARCHAR(100) NOT NULL,
    officeCode VARCHAR(10),
    CONSTRAINT fk_officeCode
    FOREIGN KEY (officeCode)
    REFERENCES offices(officeCode),
    reportsTo INT,
    CONSTRAINT fk_employeeNumber
    FOREIGN KEY (reportsTo)
    REFERENCES employees(employeeNumber),
    jobTitle VARCHAR(50) NOT NULL
);

CREATE TABLE offices(
	officeCode VARCHAR(10) PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    addressLine1 VARCHAR(50) NOT NULL,
    addressLine2 VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50) NOT NULL,
    postalCode VARCHAR(15) NOT NULL,
    territory VARCHAR(10) NOT NULL
);

CREATE TABLE customers(
	customerNumber INT PRIMARY KEY,
    customerName VARCHAR(50) NOT NULL,
    contactFirstName VARCHAR(50) NOT NULL,
    contactLastName VARCHAR(50) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    addressLine1 VARCHAR(50) NOT NULL,
    addressLine2 VARCHAR(50),
    city varchar(50) NOT NULL,
    state VARCHAR(50),
    postalCode VARCHAR(15) NOT NULL,
    country VARCHAR(50) NOT NULL,
    employeeNumber INT,
    salesRepEmployeeNumber INT,
    CONSTRAINT fk2_employeeNumber
    FOREIGN KEY (employeeNumber)
    REFERENCES employees(employeeNumber),
    creditLimit DECIMAL(10,2)
);

CREATE TABLE orders(
	orderNumber INT PRIMARY KEY,
    orderDate DATE NOT NULL,
    requiredDate DATE NOT NULL,
    shippedDate DATE,
    status VARCHAR(15) NOT NULL,
    comments TEXT,
    customerNumber INT,
    CONSTRAINT fk_ustomerNumber
    FOREIGN KEY (customerNumber)
    REFERENCES customers(customerNumber)
);

CREATE TABLE orderdetails(
	orderNumber INT,
    CONSTRAINT fk_orderNumber
    FOREIGN KEY (orderNumber)
    REFERENCES orders(orderNumber),
    productCode VARCHAR(15),
    CONSTRAINT fk_productCode
    FOREIGN KEY (productCode)
    REFERENCES products(productCode),
    quantityOrdered INT NOT NULL,
    priceEach DECIMAL(10,2) NOT NULL,
    orderLineNumber SMALLINT NOT NULL
);

CREATE TABLE payments(
	customerNumber INT,
    CONSTRAINT fk_customerNumber
    FOREIGN KEY (customerNumber)
    REFERENCES customers(customerNumber),
    checkNumber VARCHAR(50) PRIMARY KEY,
    paymentDate DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);