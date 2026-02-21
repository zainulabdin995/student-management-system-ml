# Student Management System with Machine Learning Integration

## Overview
A comprehensive desktop application engineered to digitize academic administration. It features a role-based access control system (Admin, Teacher, Student, Parent), secure MySQL database integration, and an embedded machine learning module that utilizes historical performance data to provide predictive analytics on student outcomes.



## Tech Stack
* **Frontend:** Python (Tkinter)
* **Backend Database:** MySQL
* **Data Analytics & ML:** Pandas, Scikit-learn, Matplotlib (for interactive data visualizations like boxplots and scatter plots)

## Key Features
* Role-specific dashboards with secure data entry
* Internal messaging system (Teacher-Student, etc.)
* Automated alerts and interactive performance visualizations
* Machine learning-driven predictive analytics for student performance

## How to Run
1. Import the `database/schema.sql` file into your local MySQL server.
2. Update the database connection string in `src/config.py`.
3. Install dependencies: `pip install -r requirements.txt`
4. Launch the application: `python src/main.py`
