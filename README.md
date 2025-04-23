# 📚 Library Management System – SQL Project

## 🧾 Project Overview

**Project Title:** Library Management System  
**Database:** `library_db`

This project demonstrates SQL skills by designing and querying a library management system. It includes setting up the schema for books, members, employees, and transactions, then running SQL queries to manage and analyze library operations.

---

## 🎯 Objectives

- Design and implement a relational database for a library.
- Populate the database with relevant data (books, members, employees, issued status).
- Use SQL to manage, retrieve, and analyze library data.
- Answer business questions such as most issued books, frequent members, staff involvement, etc.

---

## 🗃️ Table Creation

```sql
-- Create table "Branch"
DROP TABLE IF EXISTS branch;
CREATE TABLE branch (
  branch_id VARCHAR(10) PRIMARY KEY,
  manager_id VARCHAR(10),
  branch_address VARCHAR(30),
  contact_no VARCHAR(15)
);

-- Create table "Employee"
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
  emp_id VARCHAR(10) PRIMARY KEY,
  emp_name VARCHAR(30),
  position VARCHAR(30),
  salary DECIMAL(10,2),
  branch_id VARCHAR(10),
  FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

-- Create table "Members"
DROP TABLE IF EXISTS members;
CREATE TABLE members (
  member_id VARCHAR(10) PRIMARY KEY,
  member_name VARCHAR(30),
  member_address VARCHAR(30),
  reg_date DATE
);

-- Create table "Books"
DROP TABLE IF EXISTS books;
CREATE TABLE books (
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
CREATE TABLE issued_status (
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
CREATE TABLE return_status (
  return_id VARCHAR(10) PRIMARY KEY,
  issued_id VARCHAR(30),
  return_book_name VARCHAR(80),
  return_date DATE,
  return_book_isbn VARCHAR(50),
  FOREIGN KEY (return_book_isbn) REFERENCES books(isbn)
);

-- Altering column
ALTER TABLE books ALTER COLUMN category TYPE VARCHAR(20);
🔄 CRUD Operations
Task 1: Create a New Book Record
sql
Copy
Edit
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;
Task 2: Update an Existing Member's Address
sql
Copy
Edit
UPDATE members SET member_address = '125 Oak St' WHERE member_id = 'C103';
Task 3: Delete a Record from Issued Status
sql
Copy
Edit
DELETE FROM issued_status WHERE issued_id = 'IS121';
Task 4: Retrieve All Books Issued by a Specific Employee
sql
Copy
Edit
SELECT * FROM issued_status WHERE issued_emp_id = 'E101';
Task 5: List Members Who Have Issued More Than One Book
sql
Copy
Edit
SELECT issued_member_id, COUNT(*) 
FROM issued_status 
GROUP BY issued_member_id 
HAVING COUNT(*) > 1;
📊 CTAS – Create Table As Select
Task 6: Create Book Issue Summary Table
sql
Copy
Edit
CREATE TABLE book_issued_cnt AS
SELECT b.isbn, b.book_title, COUNT(ist.issued_id) AS issue_count
FROM issued_status AS ist
JOIN books AS b ON ist.issued_book_isbn = b.isbn
GROUP BY b.isbn, b.book_title;
📈 Data Analysis & Findings
Task 7: Retrieve All Books in a Specific Category
sql
Copy
Edit
SELECT * FROM books WHERE category = 'Classic';
Task 8: Find Total Rental Income by Category
sql
Copy
Edit
SELECT b.category, SUM(b.rental_price), COUNT(*)
FROM issued_status AS ist
JOIN books AS b ON b.isbn = ist.issued_book_isbn
GROUP BY b.category;
Task 9: List Members Registered in the Last 180 Days
sql
Copy
Edit
SELECT * FROM members WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days';
Task 10: Employees with Branch Managers and Branch Details
sql
Copy
Edit
SELECT e1.emp_id, e1.emp_name, e1.position, e1.salary, b.*, e2.emp_name AS manager
FROM employees AS e1
JOIN branch AS b ON e1.branch_id = b.branch_id
JOIN employees AS e2 ON e2.emp_id = b.manager_id;
Task 11: Create a Table of Expensive Books
sql
Copy
Edit
CREATE TABLE expensive_books AS
SELECT * FROM books WHERE rental_price > 7.00;
Task 12: Retrieve Books Not Yet Returned
sql
Copy
Edit
SELECT * 
FROM issued_status AS ist
LEFT JOIN return_status AS rs ON rs.issued_id = ist.issued_id
WHERE rs.return_id IS NULL;
⏱️ Advanced SQL Operations
Task 13: Identify Overdue Books
sql
Copy
Edit
SELECT ist.issued_member_id, m.member_name, bk.book_title, ist.issued_date,
       CURRENT_DATE - ist.issued_date AS over_dues_days
FROM issued_status AS ist
JOIN members AS m ON m.member_id = ist.issued_member_id
JOIN books AS bk ON bk.isbn = ist.issued_book_isbn
LEFT JOIN return_status AS rs ON rs.issued_id = ist.issued_id
WHERE rs.return_date IS NULL AND (CURRENT_DATE - ist.issued_date) > 30
ORDER BY 1;
Task 14: Stored Procedure – Return Book and Update Status
sql
Copy
Edit
CREATE OR REPLACE PROCEDURE add_return_records(
  p_return_id VARCHAR(10),
  p_issued_id VARCHAR(10),
  p_book_quality VARCHAR(10)
)
LANGUAGE plpgsql AS $$
DECLARE
  v_isbn VARCHAR(50);
  v_book_name VARCHAR(80);
BEGIN
  INSERT INTO return_status(return_id, issued_id, return_date, book_quality)
  VALUES (p_return_id, p_issued_id, CURRENT_DATE, p_book_quality);

  SELECT issued_book_isbn, issued_book_name INTO v_isbn, v_book_name
  FROM issued_status WHERE issued_id = p_issued_id;

  UPDATE books SET status = 'yes' WHERE isbn = v_isbn;

  RAISE NOTICE 'Thank you for returning the book: %', v_book_name;
END;
$$;
Procedure Testing
sql
Copy
Edit
CALL add_return_records('RS138', 'IS135', 'Good');
CALL add_return_records('RS148', 'IS140', 'Good');
Task 15: Branch Performance Report
sql
Copy
Edit
CREATE TABLE branch_reports AS
SELECT b.branch_id, b.manager_id,
       COUNT(ist.issued_id) AS number_book_issued,
       COUNT(rs.return_id) AS number_of_book_return,
       SUM(bk.rental_price) AS total_revenue
FROM issued_status AS ist
JOIN employees AS e ON e.emp_id = ist.issued_emp_id
JOIN branch AS b ON e.branch_id = b.branch_id
LEFT JOIN return_status AS rs ON rs.issued_id = ist.issued_id
JOIN books AS bk ON ist.issued_book_isbn = bk.isbn
GROUP BY b.branch_id, b.manager_id;
Task 16: CTAS – Active Members
sql
Copy
Edit
CREATE TABLE active_members AS
SELECT * FROM members
WHERE member_id IN (
  SELECT DISTINCT issued_member_id
  FROM issued_status
  WHERE issued_date >= CURRENT_DATE - INTERVAL '2 month'
);
Task 17: Top 3 Employees by Book Issues
sql
Copy
Edit
SELECT e.emp_name, b.*, COUNT(ist.issued_id) AS no_book_issued
FROM issued_status AS ist
JOIN employees AS e ON e.emp_id = ist.issued_emp_id
JOIN branch AS b ON e.branch_id = b.branch_id
GROUP BY e.emp_name, b.branch_id
ORDER BY no_book_issued DESC
LIMIT 3;
Task 18: Stored Procedure – Issue Book with Availability Check
sql
Copy
Edit
CREATE OR REPLACE PROCEDURE issue_book(
  p_issued_id VARCHAR(10),
  p_issued_member_id VARCHAR(30),
  p_issued_book_isbn VARCHAR(30),
  p_issued_emp_id VARCHAR(10)
)
LANGUAGE plpgsql AS $$
DECLARE
  v_status VARCHAR(10);
BEGIN
  SELECT status INTO v_status FROM books WHERE isbn = p_issued_book_isbn;

  IF v_status = 'yes' THEN
    INSERT INTO issued_status(issued_id, issued_member_id, issued_date, issued_book_isbn, issued_emp_id)
    VALUES (p_issued_id, p_issued_member_id, CURRENT_DATE, p_issued_book_isbn, p_issued_emp_id);

    UPDATE books SET status = 'no' WHERE isbn = p_issued_book_isbn;

    RAISE NOTICE 'Book records added successfully for book isbn: %', p_issued_book_isbn;
  ELSE
    RAISE NOTICE 'Sorry to inform you the book is currently unavailable. ISBN: %', p_issued_book_isbn;
  END IF;
END;
$$;
Testing
sql
Copy
Edit
CALL issue_book('IS155', 'C108', '978-0-553-29698-2', 'E104');
CALL issue_book('IS156', 'C108', '978-0-375-41398-8', 'E104');

conclusion
This SQL-based project lays the foundation for building a robust Library Management System. With practical queries and a normalized schema, it simulates real-world data handling and reporting for a library environment.
