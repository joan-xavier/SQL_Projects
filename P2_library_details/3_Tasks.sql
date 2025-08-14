### 2. CRUD Operations

-- **Create**: Inserted sample records into the `books` table.
-- **Read**: Retrieved and displayed data from various tables.
-- **Update**: Updated records in the `employees` table.
-- **Delete**: Removed records from the `members` table as needed.

-- Task 1. Create a New Book Record
-- Objective : "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"


INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;

-- Task 2 Update an Existing Member's Address from '329 Oak' st to '124 Oak st' use 'WHERE'
SELECT * FROM members;

UPDATE members
SET member_address = '125 Oak St'
WHERE member_id = 'C103';

-- Task 3: Delete a Record from the Issued Status Table (use WHERE)
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
-- Hint: use WHERE with primary key
SELECT * FROM issued_status;

DELETE FROM issued_status
WHERE issued_id = 'IS121';


-- Task 4: Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'.
SELECT * FROM employees
WHERE emp_id = 'E101'
-- 

-- Task 5 : List employees Who Have Issued More Than One Book
-- Objective: find employees who have issued more than one book.
-- Hint: use GROUP BY
SELECT * FROM issued_status;

SELECT  issued_emp_id,
COUNT(issued_id) as total_books_issued
FROM issued_status
GROUP BY 1
HAVING COUNT(issued_id)>1
ORDER BY 2 DESC;

-- ### 3. CTAS (Create Table As Select)
-- Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt

SELECT * FROM books AS b
JOIN issued_status as i
ON 