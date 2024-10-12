# Sprint 1 Retrospective

### 1. Deployed App
Taiga (project page): https://tree.taiga.io/project/aaronjones05-block-scheduler/wiki/home <br>
Taiga (sprint 1 page): https://tree.taiga.io/project/aaronjones05-block-scheduler/taskboard/gifted-macaw <br>
Deployed App: https://ea-block-scheduler-4fecd886e389.herokuapp.com/generate-schedule<br>
Team Working Agreements: https://github.com/tamu-edu-students/EA-Block-Scheduling/blob/main/documentation/Team%20Working%20Agreement.md

### 2. Dates of the Sprint
27 Sep 2024 to 11 Oct 2024

### 3. Information about Team and Member Contributions
![Imgur](https://i.imgur.com/9nP9xGj.png)

### 4. Sprint Goal 
- Create the basic app and deploy it
- Make basic UI for the login page(Button, Header...)
- Schedule generate algorithm
	- When I input mock class data, I should see a list of possible schedules with a simple algorithm, such as separating overlap.
- Build basic UI page like Aggie Schedule Builder
    - It will show the selected classes
    - It has a `Generate` button for generating schedule
    - After generating possible schedules, user can view the schedule through `View` Button
- Implement the basic database

### 5. Sprint Achievements
**Finished User Stories:**
1. Initialize the Ruby on Rails repo and configure Cucumber
2. Deploy the app to Heroku
3. Generate Schedule Page
4. Add functionality to the login and sign up buttons
5. Add a landing page


### 6. Sprint Backlog Items and Status
1. **+ Show schedule timetable**
    - This change was made as this task was not completed, so this task was backlogged for the next sprint. It will be reassigned and splitted into smaller tasks.
2. **\* Implement the basic database**
    - The database hasn't been finished yet due to some migaration problems. It will be fixed in sprint 2.
3. **+ Upload the excel spreadsheet**
    - Feature was developed successfully but the cucumber scenarios were not successfully passing so the testing is pending. Hence, pulling the story in next sprint and will be completing the story end to end.
    - Will be working on this story in sprint2
4. **\* Block Generation Algorithm**
    - Class objects were finished but the algorithm should be redesigned. Prof.Shanna provided additional information about block generating conditions and typical blocks in the meeting.
    
### 7. Burndown
![Imgur](https://i.imgur.com/LZqyTxb.png)

### 8. Design Diagrams
**System Structure:**
![Imgur](https://i.imgur.com/CCtDZlI.png)

### 9. Documentation of Changes
1. User Story #11 Show schedule timetable will be reassigned and splitted into smaller tasks.
2. The block generation algorithm will be redesigned after meeting with our client.

### 10. Evaluations of Code and Test Quality
**Test:**
![Imgur](https://i.imgur.com/9MuFZX9.png)
**Code Quality:**
Code climate will be set up in the next sprint.

### 11. Customer Meeting
Reviewing progress with Shana (client) <br>
Online meeting <br>
Oct. 10 <br>
- UI mockup
- Basic page (“Selected courses”)
- Login page for landing
- Block generation algorithm 

### 12. BDD & TDD
Cucumber scenarios and rspec examples have covered all features developed in this iteration.

