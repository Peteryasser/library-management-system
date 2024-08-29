I. Project Overview   
● Develop a feature-rich Library Management System using Ruby on Rails 7.1.3.2 
or higher, use ruby 3.3 or higher to leverage the recent YJIT compiler 
improvements.
● Utilize PostgreSQL as the database.
● Create a database schema using an Entity-Relationship Diagram (ERD)
● Implement necessary authentication and authorization mechanisms.
● Ensure proper validation and localization.
● Create a GitHub repository following the Gitflow workflow.
II. System Requirements   
A. Book Management
1. Implement books, shelves, authors, and categories.
2. Implement CRUD operations for books, authors, shelves and categories.
● Shelves should have a maximum capacity.
3. Define the book attributes:
● Book Title
● Author
● Categories ( up to 3)
● Shelf
● Rating
● Review Count
B. User Management
1. Implement user registration with verification using OTP.
2. Provide a forget/reset password functionality.
3. Implement user roles:
●    Library Admin
●    Regular User
C. Authentication and Authorization
1. Use Devise for authentication.
2. Implement role-based access control (RBAC), for example admins can 
add/update/delete books.
D. Borrowing and Returning Books
1. Allow registered users to borrow books.
2. Book borrow requests should be approved by library admins.
3. Users specify the number of days for book borrowing.
4. Implement notifications:
● Notify library admins if a book is not returned within the specified 
timeframe.
● Remind users one day before the book return deadline.
E. Search and Filtering
1. Allow users to:
●     List all books.
●     Filter books by:
○  Book Title
○  Author
○ Categories
○ Shelf
●     Sort books by highest rated or lowest rated.
F. Book Reviews
1. Users can review books after returning them.
2. Each book has a rating and a review count.
III. Development Steps   
● Set up a new Rails 7.1.3.2+ application.
● Create a database schema using an Entity-Relationship Diagram (ERD)
● Create the necessary models and migrations for books, shelves, authors, 
categories, users and borrow requests.
● Implement  necessary CRUD operations.
● Integrate Devise for user authentication.
● Implement OTP verification and forget/reset password functionality.
● Develop the borrowing and returning book functionality.
● Implement search, filtering, and sorting for books.
● Create the book review system.
● Implement localization for book attributes and errors.
● Ensure proper validation, including preventing double book borrowing.
● Set up a bitbucket repository following the Gitflow workflow. 
https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow
V. Documentation   
● Document APIs using postman include examples etc. (https://documenter.getpostman.com/view/36991213/2sA3rwNZo1)
