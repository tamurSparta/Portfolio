--Design and build a suitable normalised database to store information on the Birmingham amd Richmond training academy
--and all trainees and trainers at those locations. 


CREATE DATABASE SpartaAcademy 

--CREATING TABLES 
select * from Academies
CREATE TABLE Academies
(
    [Academy_ID] INT IDENTITY(1,1) PRIMARY KEY, -- Primary Key column
    [AcademyName] VARCHAR(50) NOT NULL,
    
);

select * from Rooms
CREATE TABLE Rooms
(
    [Room_ID] INT IDENTITY(1,1) PRIMARY KEY,
    [Academy_ID] INT FOREIGN KEY REFERENCES Academies(Academy_ID), -- foreign key which links to the Academies table via Academy_ID
    [RoomName] VARCHAR (20),
    [Description] VARCHAR(50),
    [Capacity] INT CHECK (Capacity<=25), -- constraint to set max room capacity to 25
);

select * from CourseCatalog
CREATE TABLE CourseCatalog
(
    [Course_ID] INT IDENTITY(1,1) PRIMARY KEY,
    [CourseName] VARCHAR (20),
    [Duration] VARCHAR(50),
);

DROP TABLE Employees
select * from Employees
CREATE TABLE Employees
(
    [Trainer_ID] INT IDENTITY(1,1),
    [FirstName] VARCHAR (20),
    [LastName] VARCHAR (20),
    [EmployeeType] VARCHAR(1),
    [StartDate] DATE, 
    CONSTRAINT EmployeeType CHECK (EmployeeType='T' OR EmployeeType='S') -- contraint to only allow employee type as trainers and spartans to be added 

);

select * from CourseSchedule
CREATE TABLE CourseSchedule
(
    CourseSchedule_ID INT IDENTITY(1,1) PRIMARY KEY,
    [Academy_ID] INT FOREIGN KEY REFERENCES Academies(Academy_ID),
    [Room_ID] INT FOREIGN KEY REFERENCES Rooms(Room_ID),
    [Course_ID] INT FOREIGN KEY REFERENCES CourseCatalog(Course_ID),
    [StartDate] DATE,
    [EndDate] DATE, 

);

SELECT * FROM CourseScheduleTrainers
CREATE TABLE CourseScheduleTrainers
(
    [CourseSchedule_ID] INT FOREIGN KEY REFERENCES CourseSchedule(CourseSchedule_ID),
    [Trainer_ID] INT PRIMARY KEY,
    [TrainerType] VARCHAR(1),
    CONSTRAINT TrainerType CHECK (TrainerType='T' OR TrainerType='A') -- only allowing trainers and training assistants to be contained and added  

);

SELECT * FROM CourseScheduleattendees
CREATE TABLE CourseScheduleAttendees
(
    [CourseSchedule_ID] INT FOREIGN KEY REFERENCES CourseSchedule(CourseSchedule_ID),
    [Attendee_ID] INT PRIMARY KEY,
    [Active] INT,
);




--MORE SAMPLE DATA 

INSERT INTO [CourseCatalog]
           ([CourseName]
           ,[Duration])
     VALUES
           ('Data-Engineer',
           10)
;

INSERT INTO [Employees]
            ([FirstName]
           ,[LastName]
           ,[EmployeeType]
           ,[StartDate]
           )
     VALUES
	 		     ('David','Harvey','T','12/09/2019')
				 ;

INSERT INTO [Employees]
            ([FirstName]
           ,[LastName]
           ,[EmployeeType]
           ,[StartDate]
           )
     VALUES
	 		     ('Paula','Kedra','T','12/09/2019')
				 ;

INSERT INTO [Employees]
            ([FirstName]
           ,[LastName]
           ,[EmployeeType]
           ,[StartDate]
           )
     VALUES
	 		     ('Aaron','McKenna','S','12/09/2019')
				 ;
            
INSERT INTO [Employees]
            ([FirstName]
           ,[LastName]
           ,[EmployeeType]
           ,[StartDate]
           )
     VALUES
	 		     ('Harpreet','Jhita','S','12/09/2019')
				 ;

INSERT INTO [Employees]
            ([FirstName]
           ,[LastName]
           ,[EmployeeType]
           ,[StartDate]
           )
     VALUES
	 		     ('Tamur','Khan','S','12/09/2019')
				 ;

INSERT INTO [Employees]
            ([FirstName]
           ,[LastName]
           ,[EmployeeType]
           ,[StartDate]
           )
     VALUES
	 		     ('Cassidy','Louch','S','12/09/2019')
				 ;


INSERT INTO [Employees]
            ([FirstName]
           ,[LastName]
           ,[EmployeeType]
           ,[StartDate]
           )
     VALUES
	 		     ('William','Lewis','S','12/09/2019')
				 ;

    
INSERT INTO [Employees]
            ([FirstName]
           ,[LastName]
           ,[EmployeeType]
           ,[StartDate]
           )
     VALUES
	 		     ('Jhitesh','Dhingra','S','12/09/2019')
				 ;

INSERT INTO [Employees]
            ([FirstName]
           ,[LastName]
           ,[EmployeeType]
           ,[StartDate]
           )
     VALUES
	 		     ('Edward','Snook','S','12/09/2019')
				 ;

INSERT INTO [Employees]
            ([FirstName]
           ,[LastName]
           ,[EmployeeType]
           ,[StartDate]
           )
     VALUES
	 		     ('Wai','Lau','S','12/09/2019')
				 ;

INSERT INTO [Employees]
            ([FirstName]
           ,[LastName]
           ,[EmployeeType]
           ,[StartDate]
           )
     VALUES
	 		     ('Jacob','Jenkins','S','12/09/2019')
				 ;
    
INSERT INTO [Employees]
            ([FirstName]
           ,[LastName]
           ,[EmployeeType]
           ,[StartDate]
           )
     VALUES
	 		     ('Dhiren','Mistry','S','12/09/2019')
				 ;



INSERT INTO [dbo].[CourseSchedule]
           ([Academy_ID]
           ,[Room_ID]
           ,[Course_ID]
           ,[StartDate]
           ,[EndDate])
     VALUES
           (2
           ,1
           ,3
           ,'12/09/2019'
           ,'03/01/2020'
		  )
;


INSERT INTO [CourseScheduleTrainers]
           ([CourseSchedule_ID]
           ,[Trainer_ID]
           ,[TrainerType])
     VALUES
           (3
           ,3
           ,'T')
;

INSERT INTO [CourseScheduleTrainers]
           ([CourseSchedule_ID]
           ,[Trainer_ID]
           ,[TrainerType])
     VALUES
           (3
           ,4
           ,'A')
;



INSERT INTO [CourseScheduleAttendees]
           ([CourseSchedule_ID]
           ,[Attendee_ID]
           ,[Active])
     VALUES
           (3
           ,16
           ,1)
;

INSERT INTO [CourseScheduleAttendees]
           ([CourseSchedule_ID]
           ,[Attendee_ID]
           ,[Active])
     VALUES
           (3
           ,17
           ,1)
;
INSERT INTO [CourseScheduleAttendees]
           ([CourseSchedule_ID]
           ,[Attendee_ID]
           ,[Active])
     VALUES
           (3
           ,18
           ,1)
;
INSERT INTO [CourseScheduleAttendees]
           ([CourseSchedule_ID]
           ,[Attendee_ID]
           ,[Active])
     VALUES
           (3
           ,19
           ,1)
;

INSERT INTO [CourseScheduleAttendees]
           ([CourseSchedule_ID]
           ,[Attendee_ID]
           ,[Active])
     VALUES
           (3
           ,20
           ,1)
;

INSERT INTO [CourseScheduleAttendees]
           ([CourseSchedule_ID]
           ,[Attendee_ID]
           ,[Active])
     VALUES
           (3
           ,21
           ,1)
;

INSERT INTO [CourseScheduleAttendees]
           ([CourseSchedule_ID]
           ,[Attendee_ID]
           ,[Active])
     VALUES
           (3
           ,22
           ,1)
;
INSERT INTO [CourseScheduleAttendees]
           ([CourseSchedule_ID]
           ,[Attendee_ID]
           ,[Active])
     VALUES
           (3
           ,23
           ,1)
;
INSERT INTO [CourseScheduleAttendees]
           ([CourseSchedule_ID]
           ,[Attendee_ID]
           ,[Active])
     VALUES
           (3
           ,24
           ,1)
;
INSERT INTO [CourseScheduleAttendees]
           ([CourseSchedule_ID]
           ,[Attendee_ID]
           ,[Active])
     VALUES
           (3
           ,25
           ,1)
;
INSERT INTO [CourseScheduleAttendees]
           ([CourseSchedule_ID]
           ,[Attendee_ID]
           ,[Active])
     VALUES
           (3
           ,26
           ,1)
;


