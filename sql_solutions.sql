-- inserting into issued table
INSERT INTO issued_status(issued_id, issued_member_id, issued_book_name, issued_date, issued_book_isbn, issued_emp_id) 
VALUES
('IS106', 'C106', 'Animal Farm', '2024-03-10', '978-0-330-25864-8', 'E104'),
('IS107', 'C107', 'One Hundred Years of Solitude', '2024-03-11', '978-0-14-118776-1', 'E104'),
('IS108', 'C108', 'The Great Gatsby', '2024-03-12', '978-0-525-47535-5', 'E104'),
('IS109', 'C109', 'Jane Eyre', '2024-03-13', '978-0-141-44171-6', 'E105'),
('IS110', 'C110', 'The Alchemist', '2024-03-14', '978-0-307-37840-1', 'E105'),
('IS111', 'C109', 'Harry Potter and the Sorcerers Stone', '2024-03-15', '978-0-679-76489-8', 'E105'),
('IS112', 'C109', 'A Game of Thrones', '2024-03-16', '978-0-09-957807-9', 'E106'),
('IS113', 'C109', 'A Peoples History of the United States', '2024-03-17', '978-0-393-05081-8', 'E106'),
('IS114', 'C109', 'The Guns of August', '2024-03-18', '978-0-19-280551-1', 'E106'),
('IS115', 'C109', 'The Histories', '2024-03-19', '978-0-14-044930-3', 'E107'),
('IS116', 'C110', 'Guns, Germs, and Steel: The Fates of Human Societies', '2024-03-20', '978-0-393-91257-8', 'E107'),
('IS117', 'C110', '1984', '2024-03-21', '978-0-679-64115-3', 'E107'),
('IS118', 'C101', 'Pride and Prejudice', '2024-03-22', '978-0-14-143951-8', 'E108'),
('IS119', 'C110', 'Brave New World', '2024-03-23', '978-0-452-28240-7', 'E108'),
('IS120', 'C110', 'The Road', '2024-03-24', '978-0-670-81302-4', 'E108'),
('IS121', 'C102', 'The Shining', '2024-03-25', '978-0-385-33312-0', 'E109'),
('IS122', 'C102', 'Fahrenheit 451', '2024-03-26', '978-0-451-52993-5', 'E109'),
('IS123', 'C103', 'Dune', '2024-03-27', '978-0-345-39180-3', 'E109'),
('IS124', 'C104', 'Where the Wild Things Are', '2024-03-28', '978-0-06-025492-6', 'E110'),
('IS125', 'C105', 'The Kite Runner', '2024-03-29', '978-0-06-112241-5', 'E110'),
('IS126', 'C105', 'Charlotte''s Web', '2024-03-30', '978-0-06-440055-8', 'E110'),
('IS127', 'C105', 'Beloved', '2024-03-31', '978-0-679-77644-3', 'E110'),
('IS128', 'C105', 'A Tale of Two Cities', '2024-04-01', '978-0-14-027526-3', 'E110'),
('IS129', 'C105', 'The Stand', '2024-04-02', '978-0-7434-7679-3', 'E110'),
('IS130', 'C106', 'Moby Dick', '2024-04-03', '978-0-451-52994-2', 'E101'),
('IS131', 'C106', 'To Kill a Mockingbird', '2024-04-04', '978-0-06-112008-4', 'E101'),
('IS132', 'C106', 'The Hobbit', '2024-04-05', '978-0-7432-7356-4', 'E106'),
('IS133', 'C107', 'Angels & Demons', '2024-04-06', '978-0-7432-4722-5', 'E106'),
('IS134', 'C107', 'The Diary of a Young Girl', '2024-04-07', '978-0-375-41398-8', 'E106'),
('IS135', 'C107', 'Sapiens: A Brief History of Humankind', '2024-04-08', '978-0-307-58837-1', 'E108'),
('IS136', 'C107', '1491: New Revelations of the Americas Before Columbus', '2024-04-09', '978-0-7432-7357-1', 'E102'),
('IS137', 'C107', 'The Catcher in the Rye', '2024-04-10', '978-0-553-29698-2', 'E103'),
('IS138', 'C108', 'The Great Gatsby', '2024-04-11', '978-0-525-47535-5', 'E104'),
('IS139', 'C109', 'Harry Potter and the Sorcerers Stone', '2024-04-12', '978-0-679-76489-8', 'E105'),
('IS140', 'C110', 'Animal Farm', '2024-04-13', '978-0-330-25864-8', 'E102');

SELECT * FROM issued_status;

ALTER TABLE return_status
DROP COLUMN return_book_name,
DROP COLUMN return_book_isbn;


-- inserting into return table
INSERT INTO return_status(return_id, issued_id, return_date) 
VALUES

('RS105', 'IS107', '2024-05-03'),
('RS106', 'IS108', '2024-05-05'),
('RS107', 'IS109', '2024-05-07'),
('RS108', 'IS110', '2024-05-09'),
('RS109', 'IS111', '2024-05-11'),
('RS110', 'IS112', '2024-05-13'),
('RS111', 'IS113', '2024-05-15'),
('RS112', 'IS114', '2024-05-17'),
('RS113', 'IS115', '2024-05-19'),
('RS114', 'IS116', '2024-05-21'),
('RS115', 'IS117', '2024-05-23'),
('RS116', 'IS118', '2024-05-25'),
('RS117', 'IS119', '2024-05-27'),
('RS118', 'IS120', '2024-05-29');
SELECT * FROM issued_status;
SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employee;
SELECT * FROM return_status;
SELECT * FROM members;


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
