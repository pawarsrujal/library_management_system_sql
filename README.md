 Library Management System – SQL Project
🧾 Project Overview
Project Title: Library Management System
Database: library_db

This project demonstrates SQL skills by designing and querying a library management system. It includes setting up the schema for books, members, employees, and transactions, then running SQL queries to manage and analyze library operations.

🎯 Objectives
Design and implement a relational database for a library.

Populate the database with relevant data (books, members, employees, issued status).

Use SQL to manage, retrieve, and analyze library data.

Answer business questions such as most issued books, frequent members, staff involvement, etc.

Table Creation: Created tables for branches, employees, members, books, issued status, and return status. Each table includes relevant columns and relationships.
DROP TABLE IF EXISTS branch;
CREATE TABLE branch
(
            branch_id VARCHAR(10) PRIMARY KEY,
            manager_id VARCHAR(10),
            branch_address VARCHAR(30),
            contact_no VARCHAR(15)
);


-- Create table "Employee"
DROP TABLE IF EXISTS employees;
CREATE TABLE employees
(
            emp_id VARCHAR(10) PRIMARY KEY,
            emp_name VARCHAR(30),
            position VARCHAR(30),
            salary DECIMAL(10,2),
            branch_id VARCHAR(10),
            FOREIGN KEY (branch_id) REFERENCES  branch(branch_id)
);


-- Create table "Members"
DROP TABLE IF EXISTS members;
CREATE TABLE members
(
            member_id VARCHAR(10) PRIMARY KEY,
            member_name VARCHAR(30),
            member_address VARCHAR(30),
            reg_date DATE
);



-- Create table "Books"
DROP TABLE IF EXISTS books;
CREATE TABLE books
(
            isbn VARCHAR(50) PRIMARY KEY,
            book_title VARCHAR(80),
            category VARCHAR(30),
            rental_price DECIMAL(10,2),
            status VARCHAR(10),
            author VARCHAR(30),
            publisher VARCHAR(30)
);



-- Create table "IssueStatus"
DROP TABLE IF EXISTS issued_status;
CREATE TABLE issued_status
(
            issued_id VARCHAR(10) PRIMARY KEY,
            issued_member_id VARCHAR(30),
            issued_book_name VARCHAR(80),
            issued_date DATE,
            issued_book_isbn VARCHAR(50),
            issued_emp_id VARCHAR(10),
            FOREIGN KEY (issued_member_id) REFERENCES members(member_id),
            FOREIGN KEY (issued_emp_id) REFERENCES employees(emp_id),
            FOREIGN KEY (issued_book_isbn) REFERENCES books(isbn) 
);



-- Create table "ReturnStatus"
DROP TABLE IF EXISTS return_status;
CREATE TABLE return_status
(
            return_id VARCHAR(10) PRIMARY KEY,
            issued_id VARCHAR(30),
            return_book_name VARCHAR(80),
            return_date DATE,
            return_book_isbn VARCHAR(50),
            FOREIGN KEY (return_book_isbn) REFERENCES books(isbn)
);

ALTER TABLE books
ALTER COLUMN category TYPE VARCHAR(20);

CRUD Operations
Create: Inserted sample records into the books table.
Read: Retrieved and displayed data from various tables.
Update: Updated records in the employees table.
Delete: Removed records from the members table as needed.


-- Task 1. Create a New Book Record
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;

-- Task 2: Update an Existing Member's Address
UPDATE members
SET member_address='125 Main st'
WHERE member_id='C101';


-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
DELETE FROM issued_status
WHERE issued_id='IS121';

-- Task 4: Retrieve All Books Issued by a Specific Employee 
-- Objective: Select all books issued by the employee with emp_id = 'E101'.
SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';


-- Task 5: List Members Who Have Issued More Than One Book 
-- Objective: Use GROUP BY to find members who have issued more than one book.
SELECT issued_emp_id,COUNT(issued_id) as cnt
FROM issued_status
GROUP BY issued_emp_id
HAVING COUNT(issued_id)>1;

-- CTAS
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**
SELECT b.isbn,b.book_title,COUNT(ist.issued_id)AS no_of_times FROM
books as b
JOIN issued_status as ist
on b.isbn=ist.issued_book_isbn
GROUP BY b,isbn

-- Task 7. Retrieve All Books in a Specific Category:
SELECT * FROM books
WHERE category='History';

-- Task 8: Find Total Rental Income by Category:
SELECT b.category,SUM(b.rental_price) AS total 
FROM books as b
JOIN issued_status as ist
on b.isbn=ist.issued_book_isbn
GROUP BY 1;


-- List Members Who Registered in the Last 180 Days:
SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days';
INSERT INTO members(member_id, member_name, member_address, reg_date)
VALUES
('C131', 'john', '133 Main St', '2025-04-01');


-- task 10 List Employees with Their Branch Manager's Name and their branch details:
SELECT e.*,b.branch_id,e1.emp_name as manager 
FROM employee as e
JOIN branch as b
ON b.branch_id=e.branch_id
JOIN employee as e1
ON e1.emp_id=b.manager_id


-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:
CREATE TABLE book_price_7
AS
SELECT * FROM books
WHERE rental_price>7;

SELECT * FROM book_price_7;


-- Task 12: Retrieve the List of Books Not Yet Return
SELECT * FROM return_status;
SELECT * FROM issued_status;

SELECT ist.issued_book_name,issued_book_isbn FROM issued_status as ist
LEFT JOIN return_status as rst
on ist.issued_id=rst.issued_id
WHERE rst.issued_id is NULL;

SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM members;
SELECT * FROM return_status;

/*
Task 13: 
Identify Members with Overdue Books
Write a query to identify members who have overdue books (assume a 30-day return period). 
Display the member's_id, member's name, book title, issue date, and days overdue.
*/

SELECT m.member_id,m.member_name,b.book_title,ist.issued_date,CURRENT_DATE - ist.issued_date as overdays
FROM issued_status as ist
join members as m
on ist.issued_member_id=m.member_id
join books as b
on ist.issued_book_isbn=b.isbn
left join return_status as rst
on ist.issued_id=rst.issued_id
where (CURRENT_DATE - ist.issued_date)>30 AND rst.return_date is NULL;




/*    
Task 14: Update Book Status on Return
Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).
*/



-- Store Procedures
CREATE OR REPLACE PROCEDURE add_return_records(p_return_id VARCHAR(10), p_issued_id VARCHAR(10))
LANGUAGE plpgsql
AS $$

DECLARE
    v_isbn VARCHAR(50);
    v_book_name VARCHAR(80);
    
BEGIN

  INSERT INTO return_status(return_id, issued_id, return_date)
    VALUES
    (p_return_id, p_issued_id, CURRENT_DATE);

  SELECT 
  issued_book_isbn,
  issued_book_name
  INTO
  v_isbn,
  v_book_name
  FROM issued_status
  WHERE issued_id = p_issued_id;
    UPDATE books
  SET status = 'yes'
   WHERE isbn = v_isbn;

  RAISE NOTICE 'Thank you for returning the book: %', v_book_name;
    
END;
$$
    SELECT * FROM books
WHERE isbn = '978-0-307-58837-1';
CALL add_return_records('RS138', 'IS135');


/*
Task 15: Branch Performance Report
Create a query that generates a performance report for each branch, 
showing the number of books issued, 
the number of books returned, and the total revenue generated from book rentals.
*/
SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM members;
SELECT * FROM return_status;




create table branch_report
as
SELECT b.branch_id,
	b.manager_id,
	COUNT(rs.return_id) as no_of_return,
	SUM(bk.rental_price) as revenue
FROM issued_status as ist
join employee as e
on e.emp_id=ist.issued_emp_id
join branch as b
on b.branch_id = e.branch_id
LEFT JOIN
return_status as rs
ON rs.issued_id = ist.issued_id
JOIN 
books as bk
ON ist.issued_book_isbn = bk.isbn
GROUP BY 1;


select * from branch_report;




-- Task 16: CTAS: Create a Table of Active Members
-- Use the CREATE TABLE AS (CTAS) statement to create a new table active_members 
-- containing members who have issued at least one book in the last 2 months.

SELECT * FROM members;
SELECT * FROM issued_status;
SELECT * FROM employee;



CREATE TABLE active_members
AS
SELECT m.member_name,
m.member_id
FROM issued_status as ist
left join members as m
on ist.issued_member_id=m.member_id
WHERE ist.issued_date >=CURRENT_DATE - INTERVAL '560 DAYS'
GROUP BY 1,2;

SELECT * FROM active_members;

CREATE TABLE active_members
AS
SELECT * FROM members
WHERE member_id IN (SELECT 
                        DISTINCT issued_member_id   
                    FROM issued_status
                    WHERE 
                        issued_date >= CURRENT_DATE - INTERVAL '2 month'
                    )
;


SELECT * FROM active_members;




 
-- Task 17: Find Employees with the Most Book Issues Processed
-- Write a query to find the top 3 employees who have processed the most book issues. 
--Display the employee name, number of books processed, and their branch.


SELECT e.emp_name,COUNT(ist.issued_id),b.branch_id
FROM issued_status as ist 
join employee as e
on e.emp_id=ist.issued_emp_id
join branch as b
on b.branch_id=e.branch_id
GROUP BY 1,3
LIMIT 3;



/*
Task 19: Stored Procedure Objective: 
Create a stored procedure to manage the status of books in a library system. 
Description: Write a stored procedure that updates the status of a book in the 
library based on its issuance. 
The procedure should function as follows: 
The stored procedure should take the book_id as an input parameter. 
The procedure should first check if the book is available (status = 'yes'). 
If the book is available, it should be issued, and the status in the books table 
should be updated to 'no'. 
If the book is not available (status = 'no'), the procedure should return an error 
message indicating that the book is currently not available.
*/

CREATE OR REPLACE PROCEDURE issue_book_system(p_issued_id VARCHAR(10),p_issued_member_id VARCHAR(30) ,p_issued_book_isbn VARCHAR(50),p_issued_emp_id VARCHAR(10))
LANGUAGE plpgsql
AS $$

DECLARE
	v_status VARCHAR(10);
BEGIN
	SELECT 
        status 
        INTO
        v_status
    FROM books
    WHERE isbn = p_issued_book_isbn;
	 IF v_status = 'yes' THEN

  INSERT INTO issued_status(issued_id, issued_member_id, issued_date, issued_book_isbn, issued_emp_id)
        VALUES
        (p_issued_id, p_issued_member_id, CURRENT_DATE, p_issued_book_isbn, p_issued_emp_id);

  UPDATE books
            SET status = 'no'
        WHERE isbn = p_issued_book_isbn;

  RAISE NOTICE 'Book records added successfully for book ';
		 ELSE
        RAISE NOTICE 'Sorry to inform you the book you have requested is unavailable book_isbn: %', p_issued_book_isbn;
    END IF;


END;
$$
conclusion
This SQL-based project lays the foundation for building a robust Library Management System. With practical queries and a normalized schema, it simulates real-world data handling and reporting for a library environment.
