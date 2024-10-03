# Engineering Academy Block Schedule Generator
## Overview
This project provides a software solution to generate possible block schedules for the Engineering Academies (EA) across the state, starting with the Austin EA. The program creates block schedules for math, science, and engineering courses for the spring and fall semesters, ensuring that no class overlaps and prerequisites are met. The output is provided in visual formats, replacing the current manual process that relies on spreadsheets, calendars, and Google Forms.

The intended users of this solution are EA staff and students.

## Features
+ **Automatic Block Generation:** Generates non-overlapping block schedules for math, science, and engineering sections.
+ **Prerequisite Management:** Ensures that all class prerequisites are considered when generating schedules.
+ **Support for Multiple Sections:** Accounts for multiple sections of the same class, balancing their timing and order.
+ **Spreadsheet and Visual Output:** Provides the output as a downloadable spreadsheet and a visual display for easier review and sharing.
+ **Customizable for Multiple Academies:** The software can be extended for other academies in the state.

## Technologies
+ **Backend:** Ruby on Rails (for handling business logic and data management)
+ **Database:** SQLite3 (for local development and testing), PostgreSQL (for production on Heroku)
+ **Frontend/Visualization:** HTML/CSS/JavaScript (for visual display)
+ **Data Handling:** ActiveRecord (for database operations in Rails)
+ **Spreadsheet Output:** Ruby Gems like axlsx or rubyXL (for generating Excel files)
+ **Deployment:** Heroku (for deployment and hosting)

## Important Links
+ Sprint 1 MVP Documentations:https://github.com/tamu-edu-students/EA-Block-Scheduling/tree/main/documentation/Sprint%201%20MVP
+ Team Working Agreements: https://github.com/tamu-edu-students/EA-Block-Scheduling/blob/main/documentation/Team%20Working%20Agreement.md