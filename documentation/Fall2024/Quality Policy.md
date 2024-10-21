# Quality Policy

<!-- > Describe your Quality Policy in detail for this Sprint (remember what I ask you to do when I talk about the "In your Project" part in the lectures and what is mentioned after each assignment (in due course you will need to fill out all of them, check which ones are needed for each Deliverable). You should keep adding things to this file and adjusting your policy as you go. -->

## GitHub Workflow

> 1. If you are the first to work on a **user story**, create a new **branch** from _dev_ for the user story titled _US<# of user story>_ (ex. `US3`). Otherwise, switch to the appropriate branch.
> 1. For the **task** you have taken, create a **branch** under that user story called *US<# of user story>-Task<# of task>* (ex. `US3-Task1`)
> 1. For each commit on that task, at the beginning the developer will put `US<user story>-<task number>:<commit message>` (ex. `US1-3:Made this cool logo`).
> 1. When your work on the **task** is done:
>     1. Merge _dev_ **into** your task branch to ensure that all pieces are still **functional**.
>     1. Create a **PR** to merge that task into the parent user story branch.
> 1. A different team member shall **review** the PR and run tests (as appropriate).
> 1. When a user story is complete:
>     1. Merge _dev_ **into** the user story branch to ensure that all pieces are still functional.
>     1. Create a **PR** to merge that **user story into** dev.
> 1. A different team member should **review** the PR and run the **tests** as appropriate to ensure functionality.
> 1. When the user story is merged to dev, a squash merge will be used.
> 1. When _dev_ branch is functional, only then should a **PR** be made to merge _dev_ **into _master_**, and the git master for the sprint will check and perform the merge.

## Unit Tests cucumber

> When there is a PR for a task into user story, the code reviewer will be responsible for ensuring cucumber tests pass for that task prior to merging to user story.

## Unit Tests rspec

> Every task that manipulates data will have at least 1 rspec test written by the team member who completed the task. This will be completed and run before pulling the task branch into the user story branch.

## Code Review

> Code Review policy

> All code review will be done on a first come, first serve basis, with team members taking PRs that they are comfortable reviewing. The team commits to doing their fair share, and if that's not happening, will assign PRs if needed.

## Pull Request Checklist

> **Pull Request workflow** Ensure each pull request is kept to a high standard
> - [ ] Read thoroughly the feature description to check if everything is implemented
> - [ ] Run the code and use it as an end user would. Double check requirement has been met.
> - [ ] Developer and Reviewer checklist is included in pull request
> - [ ] Increment the major version
> - [ ] Merge user story to dev

> ## Developer Checklist
> **Describe the contribution** A clear and concise description of what the contribution is.
> - [ ] Include explicitly what US and task the contribution addresses [e.g. US1-Task1]
>
> **Testing performed** Steps taken to test the contribution:
> - [ ] Every task that manipulates data will have at least 1 rspec test written by the team member who completed the task. This will be rerun ensuring tests pass before pulling the task branch into the user story branch.

> **Expected behavior changes** A clear and concise description of how this contribution will change behavior and level of impact
> - [ ] Explanation or description of how contribution should function for cucumber testing
> - [ ] Explain code that the reviewer may not understand. Make sure an explanation exists as a comment inside the code itself.
> - [ ] Add list of dependant classes below.
>
> ### Additional Information

> ## Reviewer Checklist
> - [ ] Newly written code follows code style guide
> - [ ] Naming standard is consistent
> - [ ] No excessively repeated code evident
> - [ ] Code is not overly complicated or follows behavior expressed in method comment
> - [ ] No TODO's left in code
> - [ ] No grammar or spelling errors
> - [ ] Cucumber testing was performed and tests were pushed as a new branch to task
> - [ ] Acceptance tests outlined in Taiga user story were reviewed and verified
> - [ ] Other code issues (explain below)
> - [ ] When there is a PR for a task into user story, the code reviewer will be responsible for writing a cucumber test for that task prior to merging to user story.
> - [ ] Increment minor version
> - [ ] Merge into user story
>
> **Other**:

## Static Analysis

> When a task is completed, the developer will fix rubocop exceptions related to their newly written code.

## Continuous Integration

> Any task or user story that is going to be merged must pass CI tests at the time of merge.