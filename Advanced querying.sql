
--EXERCISE 3 

--Produce a report showing the course names, start and end dates, academy names and the rooms the courses are in along with the trainers teaching 
--those courses and the trainees studying on those courses. You will have to join all 7 tables and format the date appropriately.

SELECT cc.CourseName AS 'Course Name', -- aliasing tidy column name 
FORMAT (cs.StartDate, 'dd-MM-yyyy') AS 'Start Date', --formating the date to be displayed clearer way
FORMAT (cs.EndDate, 'dd-MM-yyyy') AS 'End Date', -- same with end date 
a.AcademyName AS 'Academy Name', 
r.RoomName AS 'Room Name',
sq1.Trainer, -- getting trainer column from first subquery 
sq2.Spartan -- getting spartan column from second subquery 
FROM Academies a
JOIN Rooms r
    ON a.Academy_ID = r.Academy_ID -- joining rooms table to academies via academyID 
JOIN CourseSchedule cs
    ON a.Academy_ID = cs.Academy_ID --joining course schedule to academies via academyID
JOIN CourseCatalog cc 
    ON cs.Course_ID = cc.Course_ID  --joining course catalog to course schedule via courseID
JOIN CourseScheduleTrainers cst 
    ON cs.CourseSchedule_ID = cst.CourseSchedule_ID --  --joining course schedule trainers to course schedule via course schedule id
JOIN CourseScheduleAttendees csa 
    ON cst.CourseSchedule_ID = csa.CourseSchedule_ID  --joining course schedule attenedees to cs trainers via cs ID
JOIN Employees e 
    ON cst.Trainer_ID = e.Trainer_ID --joining employees to cs trainers via trainer id
JOIN(
    SELECT Trainer_ID, FirstName + ' ' + LastName AS 'Trainer' -- this subquery gets the first and last name of only the trainers from the employees table 
    FROM Employees
    WHERE EmployeeType = 'T')
     AS sq1 ON cst.Trainer_ID = sq1.Trainer_ID -- joining the subqry to course schedule trainers via trainer id
JOIN (
    SELECT Trainer_ID, FirstName + ' ' + LastName AS 'Spartan' -- this subquery gets the first and last name of only the spartans from the employees table 
    FROM Employees 
    WHERE EmployeeType = 'S')
     AS sq2 ON csa.Attendee_ID = sq2.Trainer_ID -- joining the subqry to course schedule attendees via trainer id and attendeeID
WHERE cs.Room_ID = r.Room_ID





--Repeat above but replace the Spartan Name column with Spartan Initials.
SELECT cc.CourseName AS 'Course Name',
FORMAT (cs.StartDate, 'dd-MM-yyyy') AS 'Start Date',
FORMAT (cs.EndDate, 'dd-MM-yyyy') AS 'End Date',
a.AcademyName AS 'Academy Name', 
r.RoomName AS 'Room Name',
sq1.Trainer,
sq2.Spartan
FROM Academies a
JOIN Rooms r
    ON a.Academy_ID = r.Academy_ID
JOIN CourseSchedule cs
    ON a.Academy_ID = cs.Academy_ID
JOIN CourseCatalog cc 
    ON cs.Course_ID = cc.Course_ID
JOIN CourseScheduleTrainers cst 
    ON cs.CourseSchedule_ID = cst.CourseSchedule_ID
JOIN CourseScheduleAttendees csa 
    ON cst.CourseSchedule_ID = csa.CourseSchedule_ID
JOIN Employees e 
    ON cst.Trainer_ID = e.Trainer_ID
JOIN(
    SELECT Trainer_ID, FirstName + ' ' + LastName AS 'Trainer'
    FROM Employees
    WHERE EmployeeType = 'T')
    AS sq1 ON cst.Trainer_ID = sq1.Trainer_ID
JOIN (
    SELECT Trainer_ID, SUBSTRING(FirstName,1,1) + '.' + SUBSTRING(LastName,1,1) AS 'Spartan'  -- getting substring from first string and only first, for both first and last name.
    FROM Employees 
    WHERE EmployeeType = 'S')
    AS sq2 ON csa.Attendee_ID = sq2.Trainer_ID 
    WHERE cs.Room_ID = r.Room_ID






--Add a new column after End Date headed “Check Date” which uses the DATEADD function to add 8 weeks to the
--Start Date column for BA Test courses and 12 weeks for any others.
SELECT cc.CourseName AS 'Course Name',
FORMAT (cs.StartDate, 'dd-MM-yyyy') AS 'Start Date',
FORMAT (cs.EndDate, 'dd-MM-yyyy') AS 'End Date',
CASE 
    WHEN cc.CourseName = 'BA-Test' THEN FORMAT(DATEADD(WEEK, 8, cs.StartDate), 'dd-MM-yyyy') -- checks for BA-Test course and adds 8 weeks to the start date 
    ELSE FORMAT(DATEADD(WEEK, 12, cs.StartDate), 'dd-MM-yyyy') -- else adds 12 weeks for any other course
    END AS 'Check Date', -- end case statment with a new column alias as Check Date 
a.AcademyName AS 'Academy Name', r.RoomName AS 'Room Name',
sq1.Trainer,
sq2.Spartan
FROM Academies a
JOIN Rooms r
    ON a.Academy_ID = r.Academy_ID
JOIN CourseSchedule cs
    ON a.Academy_ID = cs.Academy_ID
JOIN CourseCatalog cc 
    ON cs.Course_ID = cc.Course_ID
JOIN CourseScheduleTrainers cst 
    ON cs.CourseSchedule_ID = cst.CourseSchedule_ID
JOIN CourseScheduleAttendees csa 
    ON cst.CourseSchedule_ID = csa.CourseSchedule_ID
JOIN Employees e 
    ON cst.Trainer_ID = e.Trainer_ID
JOIN(
    SELECT Trainer_ID, FirstName + ' ' + LastName AS 'Trainer'
    FROM Employees
    WHERE EmployeeType = 'T'
) sq1 ON cst.Trainer_ID = sq1.Trainer_ID
JOIN (
    SELECT Trainer_ID, FirstName + ' ' + LastName AS 'Spartan'
    FROM Employees 
    WHERE EmployeeType = 'S')
    sq2 ON csa.Attendee_ID = sq2.Trainer_ID 
    WHERE cs.Room_ID = r.Room_ID
