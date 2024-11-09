# Engineering Academy Block Schedule Generator
## Important Links
+ Deployed App: https://ea-block-scheduler-4fecd886e389.herokuapp.com/
+ Code Climate: https://codeclimate.com/github/tamu-edu-students/EA-Block-Scheduling
+ Sprint 2 MVP Report: https://github.com/tamu-edu-students/EA-Block-Scheduling/blob/main/documentation/Sprint%202%20MVP/Sprint%202%20MVP%20Report.md
+ Sprint 3 MVP Report: https://github.com/tamu-edu-students/EA-Block-Scheduling/blob/main/documentation/Fall2024/Sprint%203%20MVP/Sprint%203%20MVP%20Report.md
+ Team Working Agreements: https://github.com/tamu-edu-students/EA-Block-Scheduling/blob/main/documentation/Team%20Working%20Agreement.md

## Overview
This project provides a software solution to generate possible block schedules for the Engineering Academies (EA) across the state, starting with the Austin EA. The program creates block schedules for math, science, and engineering courses for the spring and fall semesters, ensuring that no class overlaps and prerequisites are met. The output is provided in visual formats, replacing the current manual process that relies on spreadsheets, calendars, and Google Forms.

The intended users of this solution are EA staff and students.

### The Issue
Professor Shana Shaw has requested an application that would automate the process of creating block schedules for academy students to pick from when enrollment is in process. There are many classes that are often taken together, and often, classes that should be taken together have conflicting meeting times. This requires Professor Shaw to manually create a list of classes that can be taken together without conflict.

### The process
Before each semester's enrollment period opens, a partner college sends a list of classes to Professor Shaw in a spreadsheet format. Professor Shaw adds these classes to a form that creates a calendar with colorful blocks to show students what classes to take in order to not have time conflicts. The student chooses a block of classes, and the form is submitted to Professor Shaw who then enrolls the students into their chosen classes.

### Goal
1. The application will be accessible to currently accepted academy students.
2. The application will have a page for an admin user to upload a spreadsheet of available classes.
3. The application will be able to parse the spreadsheet uploaded by admins in order to differentiate between classes.
4. The application will provide clear block schedule charts based on the classes selected by students.

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
