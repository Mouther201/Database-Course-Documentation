-- 1. Count total number of students
SELECT COUNT(*) AS TotalStudents FROM Students;

-- 2. Count total number of enrollments
SELECT COUNT(*) AS TotalEnrollments FROM Enrollments;

-- 3. Average rating of each course
SELECT CourseID, AVG(Rating) AS AvgRating
FROM Enrollments
GROUP BY CourseID;

-- 4. Total number of courses per instructor
SELECT InstructorID, COUNT(*) AS CourseCount
FROM Courses
GROUP BY InstructorID;

-- 5. Number of courses in each category
SELECT CategoryID, COUNT(*) AS CourseCount
FROM Courses
GROUP BY CategoryID;

-- 6. Number of students enrolled in each course
SELECT CourseID, COUNT(*) AS EnrolledStudents
FROM Enrollments
GROUP BY CourseID;

-- 7. Average course price per category
SELECT CategoryID, AVG(Price) AS AvgPrice
FROM Courses
GROUP BY CategoryID;

-- 8. Maximum course price
SELECT MAX(Price) AS MaxCoursePrice FROM Courses;

-- 9. Min, Max, and Avg rating per course
SELECT CourseID,
       MIN(Rating) AS MinRating,
       MAX(Rating) AS MaxRating,
       AVG(Rating) AS AvgRating
FROM Enrollments
GROUP BY CourseID;

-- 10. Count how many students gave rating = 5
SELECT COUNT(*) AS FiveStarRatings
FROM Enrollments
WHERE Rating = 5;

-- INTERMEDIATE LEVEL --

-- 1. Average completion percent per course
SELECT CourseID, AVG(CompletionPercent) AS AvgCompletion
FROM Enrollments
GROUP BY CourseID;

-- 2. Students enrolled in more than 1 course
SELECT StudentID, COUNT(*) AS CoursesEnrolled
FROM Enrollments
GROUP BY StudentID
HAVING COUNT(*) > 1;

-- 3. Revenue per course (price * enrollments)
SELECT c.CourseID, c.Title, COUNT(e.EnrollmentID) AS Enrollments,
       c.Price * COUNT(e.EnrollmentID) AS Revenue
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.Title, c.Price;

-- 4. Instructor name + distinct student count
SELECT i.FullName, COUNT(DISTINCT e.StudentID) AS UniqueStudents
FROM Instructors i
JOIN Courses c ON i.InstructorID = c.InstructorID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY i.FullName;

-- 5. Average enrollments per category
SELECT CategoryID, AVG(CourseEnrollments) AS AvgEnrollments
FROM (
    SELECT Courses.CategoryID, Courses.CourseID, COUNT(e.EnrollmentID) AS CourseEnrollments
    FROM Courses
    LEFT JOIN Enrollments e ON Courses.CourseID = e.CourseID
    GROUP BY Courses.CategoryID, Courses.CourseID
) AS CategoryStats
GROUP BY CategoryID;

-- 6. Average course rating by instructor
SELECT i.FullName, AVG(e.Rating) AS AvgInstructorRating
FROM Instructors i
JOIN Courses c ON i.InstructorID = c.InstructorID
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY i.FullName;

-- 7. Top 3 courses by enrollment count
SELECT TOP 3 Courses.CourseID, Courses.Title, COUNT(Enrollments.EnrollmentID) AS EnrollmentCount
FROM Courses
JOIN Enrollments ON Courses.CourseID = Enrollments.CourseID
GROUP BY Courses.CourseID, Courses.Title
ORDER BY EnrollmentCount DESC;

-- 8. Average days students take to complete 100% (mock logic: 1 day per %)
SELECT Enrollments.CourseID,
       AVG(CompletionPercent * 1.0) AS AvgCompletionPercent,
       AVG(CompletionPercent * 1.0) AS AvgCompletionDays
FROM Enrollments
WHERE CompletionPercent = 100
GROUP BY Enrollments.CourseID;

-- 9. Percentage of students who completed each course
SELECT Enrollments.CourseID,
       COUNT(CASE WHEN CompletionPercent = 100 THEN 1 END) * 100.0 / COUNT(*) AS CompletionRate
FROM Enrollments
GROUP BY Enrollments.CourseID;

-- 10. Count courses published each year
SELECT YEAR(PublishDate) AS YearPublished, COUNT(*) AS CourseCount
FROM Courses
GROUP BY YEAR(PublishDate);
