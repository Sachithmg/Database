SELECT 'Check for DB exist, if so, drop the database' AS 'Promot for stage';
DROP DATABASE IF EXISTS finall_db;

SELECT 'Create database \'finall_db\'' AS 'Promot for stage';
CREATE DATABASE finall_db; 

USE finall_db;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;

/*
Tables are created without using the NOT NULL AUTO_INCREMENT attribute for primary key fields.
This approach simplifies and enhances the effectiveness of data population scripts across
different setups. By not automatically incrementing primary keys, we avoid the need to retrieve
primary key values based on existing data, which can add an extra step when referencing
primary keys from main tables. This method allows for more direct control over key management
and data insertion processes.
*/

SELECT 'Create table Department' AS 'Promot for stage';
CREATE TABLE Department (
  DepartmentID INT  PRIMARY KEY,
  DepartmentName VARCHAR(255) NOT NULL
)ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DESC Department;

SELECT 'Create table Student' AS 'Promot for stage';
CREATE TABLE Student (
  StudentID INT PRIMARY KEY,
  FirstName VARCHAR(50) NOT NULL,
  MiddleName VARCHAR(50),
  LastName VARCHAR(50) NOT NULL,
  Gender ENUM('Male', 'Female', 'Other') NOT NULL,
  DateOfBirth DATE NOT NULL,
  HouseNo VARCHAR(50),
  RoadName VARCHAR(255),
  Area VARCHAR(255),
  City VARCHAR(50),
  Country VARCHAR(50),
  PostCode VARCHAR(10),
  Email VARCHAR(100),
  MobileNo VARCHAR(15)
)ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DESC Student;

SELECT 'Create table Course' AS 'Promot for stage';
CREATE TABLE Course (
  CourseID INT PRIMARY KEY,
  Code VARCHAR(20) NOT NULL,
  Name VARCHAR(255) NOT NULL,
  Description TEXT,
  Credit INT NOT NULL,
  Level VARCHAR(10) NOT NULL,
  Hours INT NOT NULL,
  DepartmentID INT,
  FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID) 
    ON UPDATE CASCADE 
    ON DELETE SET NULL
)ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DESC Course;

SELECT 'Create table Enrollment' AS 'Promot for stage';
CREATE TABLE Enrollment (
  EnrollmentID INT PRIMARY KEY,
  StudentID INT NOT NULL,
  CourseID INT NOT NULL,
  StartDate DATE NOT NULL,
  Grade VARCHAR(2),
  FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
    ON UPDATE CASCADE 
    ON DELETE CASCADE,
  FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
    ON UPDATE CASCADE 
    ON DELETE CASCADE
)ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DESC Enrollment;

SELECT 'Create table Semester' AS 'Promot for stage';
CREATE TABLE Semester (
  SemesterID INT PRIMARY KEY,
  SemesterName VARCHAR(100) NOT NULL,
  Year INT NOT NULL,
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL
)ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DESC Semester;

SELECT 'Create table StudentDepartment' AS 'Promot for stage';
CREATE TABLE StudentDepartment (
  StudentID INT,
  DepartmentID INT,
  MajorStartDate DATE NOT NULL,
  IsPrimary BOOLEAN NOT NULL,
  PRIMARY KEY (StudentID, DepartmentID),
  FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
    ON UPDATE CASCADE 
    ON DELETE CASCADE,
  FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
    ON UPDATE CASCADE 
    ON DELETE CASCADE
)ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DESC StudentDepartment;

SELECT 'Create table CourseSemesterEnrollment' AS 'Promot for stage';
CREATE TABLE CourseSemesterEnrollment (
  EnrollmentID INT,
  SemesterID INT,
  SemesterGrade VARCHAR(2),
  PRIMARY KEY (EnrollmentID, SemesterID),
  FOREIGN KEY (EnrollmentID) REFERENCES Enrollment(EnrollmentID)
    ON UPDATE CASCADE 
    ON DELETE CASCADE,
  FOREIGN KEY (SemesterID) REFERENCES Semester(SemesterID)
    ON UPDATE CASCADE 
    ON DELETE CASCADE
)ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DESC CourseSemesterEnrollment;


/*Insert scripts*/

SELECT 'Insert records into Department table' AS 'Promot for stage';

INSERT INTO Department (DepartmentID, DepartmentName) VALUES
(1, 'Computer Engineering'),
(2, 'Computer Science'),
(3, 'Mechanical Engineering'),
(4, 'Electrical Engineering'),
(5, 'Humanities');

SELECT 'Out Department table' AS 'Promot for stage';
SELECT * FROM Department;

SELECT 'Insert records into Student table' AS 'Promot for stage';

INSERT INTO Student (StudentID, FirstName, MiddleName, LastName, Gender, DateOfBirth, HouseNo, RoadName, Area, City, Country, PostCode, Email, MobileNo) VALUES
(1, 'Liam', 'John', 'Wilson', 'Male', '2001-04-23', '12', 'High Street', 'Central', 'Wellington', 'New Zealand', '6011', 'liamwilson@email.com', '021-123-4567'),
(2, 'Olivia', 'Jane', 'Smith', 'Female', '2002-05-19', '34', 'King Street', 'East', 'Auckland', 'New Zealand', '1010', 'olivia.smith@email.com', '022-234-5678'),
(3, 'Noah', 'James', 'Brown', 'Male', '2000-03-30', '56', 'Queen Street', 'West', 'Christchurch', 'New Zealand', '8011', 'noah.brown@email.com', '023-345-6789'),
(4, 'Emma', 'Charlotte', 'Taylor', 'Female', '2003-07-22', '78', 'Victoria Street', 'South', 'Dunedin', 'New Zealand', '9016', 'emma.taylor@email.com', '024-456-7890'),
(5, 'Sophia', 'Marie', 'Jones', 'Female', '1999-12-13', '90', 'Elizabeth Street', 'North', 'Hamilton', 'New Zealand', '3204', 'sophia.jones@email.com', '025-567-8901'),
(6, 'Mason', 'Alexander', 'Lee', 'Male', '2002-11-05', '100', 'Lincoln Road', 'Central', 'Tauranga', 'New Zealand', '3110', 'mason.lee@email.com', '026-678-9012'),
(7, 'Isabella', 'Ann', 'Wilson', 'Female', '2001-09-15', '110', 'Lake Road', 'East', 'Palmerston North', 'New Zealand', '4410', 'isabella.wilson@email.com', '027-789-0123'),
(8, 'Lucas', 'George', 'Davis', 'Male', '2002-02-20', '120', 'Park Avenue', 'West', 'Nelson', 'New Zealand', '7010', 'lucas.davis@email.com', '028-890-1234'),
(9, 'Mia', 'Elizabeth', 'White', 'Female', '2003-01-17', '130', 'Church Street', 'South', 'Invercargill', 'New Zealand', '9810', 'mia.white@email.com', '029-901-2345'),
(10, 'Ethan', 'Robert', 'Martin', 'Male', '1998-08-25', '140', 'Station Road', 'North', 'New Plymouth', 'New Zealand', '4310', 'ethan.martin@email.com', '030-012-3456');

SELECT 'Out Student table' AS 'Promot for stage';
SELECT * FROM Student;

SELECT 'Insert records into Course table' AS 'Promot for stage';

INSERT INTO Course (CourseID, Code, Name, Description, Credit, Level, Hours, DepartmentID) VALUES
(1, 'GP106', 'Introduction to Programming', 'Learn the basics of programming.', 3, 100, 45, 1),
(2, 'CS205', 'Data Structures', 'Advanced data organization techniques.', 3, 200, 30, 2),
(3, 'CS303', 'Operating Systems', 'In-depth study of modern operating systems.', 4, 300, 60, 2),
(4, 'ME101', 'Intro to Mechanics', 'Foundational mechanics for engineers.', 3, 100, 45, 3),
(5, 'EE202', 'Circuit Analysis', 'Analyzing complex electrical circuits.', 4, 200, 50, 4),
(6, 'HU103', 'World History', 'A survey of world historical events and figures.', 3, 100, 40, 5),
(7, 'CS404', 'Machine Learning', 'Techniques and applications of machine learning.', 4, 400, 60, 2);

SELECT 'Out Course table' AS 'Promot for stage';
SELECT * FROM Course;

SELECT 'Insert records into Semester table' AS 'Promot for stage';

INSERT INTO Semester (SemesterID, SemesterName, Year, StartDate, EndDate) VALUES
(1, '2023-Jan', 2023, '2023-01-01', '2023-03-31'),
(2, '2023-April', 2023, '2023-04-01', '2023-06-30'),
(3, '2023-July', 2023, '2023-07-01', '2023-09-30'),
(4, '2023-Oct', 2023, '2023-10-01', '2023-12-31'),
(5, '2024-Jan', 2024, '2024-01-01', '2024-03-31'),
(6, '2024-April', 2024, '2024-04-01', '2024-06-30'),
(7, '2024-July', 2024, '2024-07-01', '2024-09-30'),
(8, '2024-Oct', 2024, '2024-10-01', '2024-12-31');

SELECT 'Out Semester table' AS 'Promot for stage';
SELECT * FROM Semester;

SELECT 'Insert records into Enrollment table' AS 'Promot for stage';

-- Enrollment setup with extended semesters
INSERT INTO Enrollment (EnrollmentID, StudentID, CourseID, StartDate, Grade) VALUES
-- Student 1 enrolls in 2 courses, extending into 2024
(1, 1, 1, '2023-01-01', 'A'), 
(2, 1, 3, '2023-04-01', 'A'), 
(3, 1, 2, '2024-01-01', 'A'), 
-- Student 2 enrolls in 2 different courses
(4, 2, 1, '2023-04-01', 'B'), 
(5, 2, 2, '2024-01-01', 'B'), 
-- Student 3 enrolls in the same course across multiple semesters
(6, 3, 1, '2023-01-01', 'C'), 
(7, 3, 1, '2023-04-01', 'B'), 
(8, 3, 2, '2024-04-01', 'B'),
-- Student 4 enrolls in multiple courses
(9, 4, 2, '2023-04-01', 'A'), 
(10, 4, 4, '2023-10-01', 'A'),
-- Student 5 enrolls in multiple courses
(11, 5, 2, '2023-04-01', 'B'), 
(12, 5, 5, '2024-04-01', 'B'),
-- Additional enrollments for students 6 and 7
(13, 6, 3, '2023-01-01', 'C'),
(14, 7, 4, '2023-04-01', 'D');

SELECT 'Out Enrollment table' AS 'Promot for stage';
SELECT * FROM Enrollment;

SELECT 'Insert records into StudentDepartment table' AS 'Promot for stage';

INSERT INTO StudentDepartment (StudentID, DepartmentID, MajorStartDate, IsPrimary) VALUES
(1, 1, '2023-01-01', TRUE),
(2, 1, '2023-01-01', TRUE),
(3, 1, '2023-01-01', TRUE),
(1, 2, '2023-01-01', FALSE);  -- Example of a student with a secondary major

SELECT 'Out StudentDepartment table' AS 'Promot for stage';
SELECT * FROM StudentDepartment;

SELECT 'Insert records into CourseSemesterEnrollment table' AS 'Promot for stage';

-- CourseSemesterEnrollment reflecting multiple semesters
INSERT INTO CourseSemesterEnrollment (EnrollmentID, SemesterID, SemesterGrade) VALUES
(1, 1, 'A'),  -- Student 1 in Semester 2023-Jan
(1, 2, 'A'),  -- Continuation in Semester 2023-April
(1, 5, 'A'),  -- Continuing into Semester 2024-Jan
(2, 2, 'B'),  -- Student 2 in Semester 2023-April
(2, 5, 'B'),  -- Continuing into Semester 2024-Jan
(3, 1, 'C'),  -- Student 3 in Semester 2023-Jan
(3, 2, 'B'),  -- Continuation in Semester 2023-April
(3, 6, 'B'),  -- Continuing into Semester 2024-April
(4, 6, 'A'),  -- Student 4 in Semester 2024-April
(4, 4, 'A'),  -- Continuation in Semester 2023-Oct
(5, 2, 'B'),  -- Student 5 in Semester 2023-April
(5, 6, 'B'),  -- Continuing into Semester 2024-April
(6, 5, 'C'),  -- Continuing into Semester 2024-Jan
(7, 6, 'B'),  -- Continuing into Semester 2024-April
(8, 5, 'B'),  -- Continuing into Semester 2024-Jan
(9, 5, 'A'),  -- Continuing into Semester 2024-Jan
(10, 5, 'A'),  -- Continuing into Semester 2024-Jan
(11, 5, 'B'),  -- Continuing into Semester 2024-Jan
(12, 5, 'B'),  -- Continuing into Semester 2024-Jan
(13, 5, 'C'),  -- Continuing into Semester 2024-Jan
(14, 5, 'D');  -- Continuing into Semester 2024-Jan

SELECT 'Out CourseSemesterEnrollment table' AS 'Promot for stage';
SELECT * FROM CourseSemesterEnrollment;


--Query 1: Retrieve all students majoring in “Computer Engineering”.
SELECT 
    s.StudentID,
    s.FirstName,
    s.MiddleName,
    s.LastName,
    s.Gender,
    s.DateOfBirth,
    s.HouseNo,
    s.RoadName,
    s.Area,
    s.City,
    s.Country,
    s.PostCode,
    s.Email,
    s.MobileNo
FROM 
    Student s
JOIN 
    StudentDepartment sd ON s.StudentID = sd.StudentID
JOIN 
    Department d ON sd.DepartmentID = d.DepartmentID
WHERE 
    d.DepartmentName = 'Computer Engineering';

--Query 2:List all courses along with the number of students enrolled in each.
SELECT 
    c.Code AS 'Course Code',
    c.Name AS 'Course Name',
    COUNT(e.StudentID) AS 'Number of Students'
FROM 
    Course c
LEFT JOIN 
    Enrollment e ON c.CourseID = e.CourseID
GROUP BY 
    c.CourseID, c.Code, c.Name;
	
	
--	Query 3: Find the average grade of students in the ‘GP106’ course for the ‘2024-April’ semester. 
SELECT 
    c.Code, 
    s.SemesterName,
    AVG(
        CASE e.Grade
            WHEN 'F' THEN 20
            WHEN 'D' THEN 40
            WHEN 'C' THEN 50
            WHEN 'B' THEN 60
            WHEN 'A' THEN 70
            ELSE 0
        END
    ) AS 'Average Grade'
FROM 
    Course c
JOIN 
    Enrollment e ON c.CourseID = e.CourseID
JOIN 
    CourseSemesterEnrollment cse ON e.EnrollmentID = cse.EnrollmentID
JOIN 
    Semester s ON cse.SemesterID = s.SemesterID
WHERE 
    c.Code = 'GP106'
    AND s.SemesterName = '2024-April';



--------------------------------------------------------------------	
SELECT 
    c.Code AS 'Course Code',
    s.SemesterName AS 'Semester Name',
    AVG(
        CASE e.Grade
            WHEN 'F' THEN 20
            WHEN 'D' THEN 40
            WHEN 'C' THEN 50
            WHEN 'B' THEN 60
            WHEN 'A' THEN 70
            ELSE 0
        END
    ) AS 'Average Numeric Grade',
    CASE
        WHEN AVG(
            CASE e.Grade
                WHEN 'F' THEN 20
                WHEN 'D' THEN 40
                WHEN 'C' THEN 50
                WHEN 'B' THEN 60
                WHEN 'A' THEN 70
                ELSE 0
            END
        ) BETWEEN 0 AND 29 THEN 'F'
        WHEN AVG(
            CASE e.Grade
                WHEN 'F' THEN 20
                WHEN 'D' THEN 40
                WHEN 'C' THEN 50
                WHEN 'B' THEN 60
                WHEN 'A' THEN 70
                ELSE 0
            END
        ) BETWEEN 30 AND 44 THEN 'D'
        WHEN AVG(
            CASE e.Grade
                WHEN 'F' THEN 20
                WHEN 'D' THEN 40
                WHEN 'C' THEN 50
                WHEN 'B' THEN 60
                WHEN 'A' THEN 70
                ELSE 0
            END
        ) BETWEEN 45 AND 54 THEN 'C'
        WHEN AVG(
            CASE e.Grade
                WHEN 'F' THEN 20
                WHEN 'D' THEN 40
                WHEN 'C' THEN 50
                WHEN 'B' THEN 60
                WHEN 'A' THEN 70
                ELSE 0
            END
        ) BETWEEN 55 AND 69 THEN 'B'
        WHEN AVG(
            CASE e.Grade
                WHEN 'F' THEN 20
                WHEN 'D' THEN 40
                WHEN 'C' THEN 50
                WHEN 'B' THEN 60
                WHEN 'A' THEN 70
                ELSE 0
            END
        ) >= 70 THEN 'A'
        ELSE 'N/A'  -- Handles cases where an average cannot be calculated
    END AS 'Average Letter Grade'
FROM 
    Course c
JOIN 
    Enrollment e ON c.CourseID = e.CourseID
JOIN 
    CourseSemesterEnrollment cse ON e.EnrollmentID = cse.EnrollmentID
JOIN 
    Semester s ON cse.SemesterID = s.SemesterID
WHERE 
    c.Code = 'GP106'
    AND s.SemesterName = '2024-April'
GROUP BY
    c.Code, s.SemesterName;
	
	
--	Query 4: Retrieve all students who have an ‘A’ grade in any course. 
SELECT 
    s.StudentID,
    s.FirstName,
    s.MiddleName,
    s.LastName,
    s.Gender,
    s.DateOfBirth,
    s.Email,
    s.MobileNo,
    c.Code AS 'Course Code',
    c.Name AS 'Course Name',
    e.Grade
FROM 
    Student s
JOIN 
    Enrollment e ON s.StudentID = e.StudentID
JOIN 
    Course c ON e.CourseID = c.CourseID
WHERE 
    e.Grade = 'A';   
	

--Query 5:Find all students who are enrolled in more than 3 courses. 
SELECT 
    s.StudentID,
    s.FirstName,
    s.MiddleName,
    s.LastName,
    s.Gender,
    s.DateOfBirth,
    s.Email,
    s.MobileNo,
    COUNT(DISTINCT e.CourseID) AS 'Number of Courses'
FROM 
    Student s
JOIN 
    Enrollment e ON s.StudentID = e.StudentID
JOIN 
    Course c ON e.CourseID = c.CourseID
GROUP BY 
    s.StudentID, s.FirstName, s.MiddleName, s.LastName, s.Gender, s.DateOfBirth, s.Email, s.MobileNo
HAVING 
    COUNT(DISTINCT e.CourseID) >3;
	
	
--Query 5.1:Find all students who are enrolled in more than or equal to 3 courses. 
SELECT 
    s.StudentID,
    s.FirstName,
    s.MiddleName,
    s.LastName,
    s.Gender,
    s.DateOfBirth,
    s.Email,
    s.MobileNo,
    COUNT(DISTINCT e.CourseID) AS 'Number of Courses'
FROM 
    Student s
JOIN 
    Enrollment e ON s.StudentID = e.StudentID
JOIN 
    Course c ON e.CourseID = c.CourseID
GROUP BY 
    s.StudentID, s.FirstName, s.MiddleName, s.LastName, s.Gender, s.DateOfBirth, s.Email, s.MobileNo
HAVING 
    COUNT(DISTINCT e.CourseID) >=3;
	

--	Query 6: Update grades for all students in the ‘GP106’ course for the ‘2024-April’ semester to ‘B’
SELECT 
    s.FirstName,
    s.MiddleName,
    s.LastName,
    s.Gender,
    s.DateOfBirth,
    s.Email,
    c.Code AS 'Course Code',
    c.Name AS 'Course Name',
    sem.SemesterName AS 'Semester',
    e.Grade
FROM 
    Student s
JOIN 
    Enrollment e ON s.StudentID = e.StudentID
JOIN 
    Course c ON e.CourseID = c.CourseID
JOIN 
    CourseSemesterEnrollment cse ON e.EnrollmentID = cse.EnrollmentID
JOIN 
    Semester sem ON cse.SemesterID = sem.SemesterID
WHERE 
    c.Code = 'GP106'
    AND sem.SemesterName = '2024-April';


--Change update to A Grade because current records are already having B	
UPDATE Enrollment e
JOIN Course c ON e.CourseID = c.CourseID
JOIN CourseSemesterEnrollment cse ON e.EnrollmentID = cse.EnrollmentID
JOIN Semester sem ON cse.SemesterID = sem.SemesterID
SET e.Grade = 'A'
WHERE c.Code = 'GP106'
  AND sem.SemesterName = '2024-April';



