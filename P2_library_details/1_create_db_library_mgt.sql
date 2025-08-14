-- Library details and management system Project 2
-- create table 'branch'
DROP TABLE IF EXISTS branch;
CREATE TABLE branch
(
	branch_id VARCHAR(10) PRIMARY KEY,
	manager_id VARCHAR(10),
	branch_address VARCHAR(60),
	contact_no VARCHAR(25)
);

-- incase if any coloumn date needs t be changed after creating table use alter table
ALTER TABLE branch
ALTER COLUMN contact_no TYPE VARCHAR(30);


DROP TABLE IF EXISTS employees;
CREATE TABLE employees(
	emp_id	VARCHAR(10) PRIMARY KEY,
	emp_name VARCHAR(20),
	position VARCHAR(25),
	salary	INT,
	branch_id VARCHAR(20) --FK
);
ALTER TABLE employees
ALTER COLUMN salary TYPE FLOAT;

-- creater table books
DROP TABLE IF EXISTS books;
CREATE TABLE books(
	isbn VARCHAR(20) PRIMARY KEY,
	book_title	VARCHAR(75),
	category VARCHAR(30),
	rental_price FLOAT,
	status VARCHAR(10),
	author VARCHAR(35),
	publisher VARCHAR (60)
);
-- create table members
DROP TABLE IF EXISTS members;
CREATE TABLE members(
member_id VARCHAR(20) PRIMARY KEY,
member_name	VARCHAR(30),
member_address	VARCHAR(75),
reg_date DATE
);

-- create table issued_status
DROP TABLE IF EXISTS issued_status;
CREATE TABLE issued_status
(
	issued_id	VARCHAR(10) PRIMARY KEY,
	issued_member_id VARCHAR(10), -- FK
	issued_book_name VARCHAR(75),
	issued_date	DATE,
	issued_book_isbn VARCHAR(30), --FK
	issued_emp_id VARCHAR(25) --FK
);

-- create table return_status

DROP TABLE IF EXISTS return_status;
CREATE TABLE return_status(
return_id VARCHAR(20) PRIMARY KEY,
issued_id	VARCHAR(20),
return_book_name VARCHAR(75),
return_date	DATE,
return_book_isbn VARCHAR(40)
);

-- FOREGIN key
-- to create a FK use ALTER command
-- adding 3 foreign keys to issued_status table
ALTER TABLE issued_status
ADD CONSTRAINT fk_members
FOREIGN KEY(issued_member_id)
REFERENCES members(member_id);

ALTER TABLE issued_status
ADD CONSTRAINT fk_books
FOREIGN KEY(issued_book_isbn)
REFERENCES books(isbn);

ALTER TABLE issued_status
ADD CONSTRAINT fk_employees
FOREIGN KEY(issued_emp_id)
REFERENCES employees(emp_id);

-- adding FK to employees table
ALTER TABLE employees
ADD CONSTRAINT fk_branch
FOREIGN KEY(branch_id)
REFERENCES branch(branch_id);

-- adding FK in the return_status table
ALTER TABLE return_status
ADD CONSTRAINT fk_issued_status
FOREIGN KEY(issued_id)
REFERENCES issued_status(issued_id);