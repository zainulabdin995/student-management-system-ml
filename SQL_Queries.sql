CREATE DATABASE IF NOT EXISTS student_db;
USE student_db;

CREATE TABLE IF NOT EXISTS students (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    gender VARCHAR(10),
    age INT,
    section VARCHAR(1),
    science FLOAT,
    english FLOAT,
    history FLOAT,
    maths FLOAT
);

CREATE TABLE IF NOT EXISTS predictions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    science FLOAT,
    english FLOAT,
    history FLOAT,
    predicted_maths FLOAT,
    prediction_date DATETIME
);

CREATE TABLE IF NOT EXISTS models (
    id INT AUTO_INCREMENT PRIMARY KEY,
    model_name VARCHAR(255),
    model_data LONGBLOB,
    created_date DATETIME
);

USE student_db;

CREATE TABLE IF NOT EXISTS grades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    science_grade VARCHAR(2),
    english_grade VARCHAR(2),
    history_grade VARCHAR(2),
    maths_grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(id)
);

-- Populate grades based on existing data
INSERT INTO grades (student_id, science_grade, english_grade, history_grade, maths_grade)
SELECT id,
    CASE
        WHEN science >= 90 THEN 'A'
        WHEN science >= 80 THEN 'B'
        WHEN science >= 70 THEN 'C'
        WHEN science >= 60 THEN 'D'
        WHEN science >= 40 THEN 'E'
        ELSE 'F'
    END AS science_grade,
    CASE
        WHEN english >= 90 THEN 'A'
        WHEN english >= 80 THEN 'B'
        WHEN english >= 70 THEN 'C'
        WHEN english >= 60 THEN 'D'
        WHEN english >= 40 THEN 'E'
        ELSE 'F'
    END AS english_grade,
    CASE
        WHEN history >= 90 THEN 'A'
        WHEN history >= 80 THEN 'B'
        WHEN history >= 70 THEN 'C'
        WHEN history >= 60 THEN 'D'
        WHEN history >= 40 THEN 'E'
        ELSE 'F'
    END AS history_grade,
    CASE
        WHEN maths >= 90 THEN 'A'
        WHEN maths >= 80 THEN 'B'
        WHEN maths >= 70 THEN 'C'
        WHEN maths >= 60 THEN 'D'
        WHEN maths >= 40 THEN 'E'
        ELSE 'F'
    END AS maths_grade
FROM students;

USE student_db;

-- Existing tables updated
ALTER TABLE students ADD COLUMN created_date DATETIME DEFAULT CURRENT_TIMESTAMP;

-- New Tables
CREATE TABLE ExamResults (
    student_id INT,
    exam_id INT,
    subject VARCHAR(50),
    score DECIMAL(5,2),
    exam_date DATETIME,
    FOREIGN KEY (student_id) REFERENCES students(id)
);

CREATE TABLE Attendance (
    student_id INT,
    date DATE,
    subject VARCHAR(50),
    status ENUM('Present', 'Absent'),
    FOREIGN KEY (student_id) REFERENCES students(id)
);

CREATE TABLE Assignments (
    student_id INT,
    title VARCHAR(100),
    due_date DATETIME,
    status ENUM('Submitted', 'Pending', 'Late'),
    grade DECIMAL(5,2),
    FOREIGN KEY (student_id) REFERENCES students(id)
);

CREATE TABLE Timetable (
    day VARCHAR(10),
    time_slot VARCHAR(20),
    section VARCHAR(2),
    subject VARCHAR(50),
    teacher_id INT
);

CREATE TABLE SubjectRegistration (
    student_id INT,
    subject_id INT,
    FOREIGN KEY (student_id) REFERENCES students(id)
);

CREATE TABLE Teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    subject VARCHAR(50),
    section VARCHAR(2)
);

CREATE TABLE Transfers (
    student_id INT,
    from_section VARCHAR(2),
    to_section VARCHAR(2),
    date DATETIME,
    FOREIGN KEY (student_id) REFERENCES students(id)
);

CREATE TABLE Fees (
    student_id INT,
    due_date DATETIME,
    amount DECIMAL(10,2),
    status ENUM('Paid', 'Due', 'Overdue'),
    FOREIGN KEY (student_id) REFERENCES students(id)
);

CREATE TABLE Library (
    student_id INT,
    book_id INT,
    borrow_date DATETIME,
    return_date DATETIME,
    status ENUM('Borrowed', 'Returned', 'Overdue'),
    FOREIGN KEY (student_id) REFERENCES students(id)
);

CREATE TABLE Events (
    student_id INT,
    event_id INT,
    participation_status ENUM('Participated', 'Not Participated'),
    FOREIGN KEY (student_id) REFERENCES students(id)
);

CREATE TABLE Feedback (
    student_id INT,
    teacher_id INT,
    rating INT,
    comment TEXT,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
);

-- Initial Teacher Data
INSERT INTO Teachers (name, subject, section) VALUES
('TeacherA', 'Maths', 'A'),
('TeacherB', 'Science', 'B'),
('TeacherC', 'History', 'C');

USE student_db;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    role ENUM('Admin', 'Teacher', 'Student', 'Parent'),
    user_id INT, -- Links to student_id, teacher_id, or child student_id
    section VARCHAR(2), -- For teachers
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Insert initial admin user
INSERT INTO users (username, password, role, user_id) VALUES ('admin', 'admin123', 'Admin', 1);

-- Update registration logic to populate this table

INSERT INTO users (username, password, role, user_id) VALUES ('admin', 'admin123', 'Admin', 1);

USE student_db;

-- Remove unique constraint on Teachers.name if it exists
ALTER TABLE Teachers DROP INDEX IF EXISTS name;

-- Create Messages table for all messaging
CREATE TABLE IF NOT EXISTS Messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT,
    sender_role ENUM('Teacher', 'Student'),
    receiver_id INT,
    receiver_role ENUM('Teacher', 'Student'),
    message TEXT,
    sent_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Create Alerts table if not already present
CREATE TABLE IF NOT EXISTS Alerts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    message TEXT,
    sent_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(id)
);


