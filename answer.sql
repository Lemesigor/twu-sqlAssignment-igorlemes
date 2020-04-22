-- Q1:
--Who checked out the book 'The Hobbit’?

-- A:
-- Anand Beck

SELECT member.name 
FROM member 
JOIN checkout_item ON (member.id = checkout_item.member_id) JOIN book ON (checkout_item.book_id = book.id) 
WHERE book.title = 'The Hobbit';
 -----------------

-- Q2:
-- How many people have not checked out anything?

-- A:
--37

SELECT count(member.name) 
FROM member
WHERE member.id not IN(
    SELECT member_id
    FROM checkout_item
);
------------------

-- Q3:
-- What books and movies aren't checked out?

-- A:
-- Books:
-- Fellowship of the Ring
-- 1984
-- Tom Sawyer
-- Catcher in the Rye
-- To Kill a Mockingbird
-- Domain Driven Design

-- Movies:
-- Thin Red Line
-- Crouching Tiger, Hidden Dragon
-- Lawrence of Arabia
-- Office Space

SELECT  title
FROM book 
WHERE not EXISTS (
    SELECT book_id
    FROM checkout_item
    WHERE book.id = checkout_item.book_id
);

SELECT  title
FROM movie 
WHERE not EXISTS (
    SELECT movie_id
    FROM checkout_item
    WHERE movie.id = checkout_item.movie_id
);
------------------------------------------

--Q4:
-- Add the book 'The Pragmatic Programmer', and add yourself as a member. Check out 'The Pragmatic Programmer'. Use your query from question 1 to verify that you have checked it out. 
-- Also, provide the SQL used to update the database.

INSERT INTO book VALUES (11, 'The Pragmatic Programmer');
INSERT INTO member VALUES (43, 'Igor Lemes');
INSERT INTO checkout_item(member_id,book_id) VALUES (43,11);
-----------------------------------------------

-- Q5:
-- Who has checked out more than 1 item?

--A:
--Total | Name
-- 3    | Anand Beck
-- 3    | Frank Smith

SELECT count(member_id), name
FROM checkout_item LEFT JOIN member ON (member_id = id)
GROUP BY member_id
HAVING count(member_id) > 1;