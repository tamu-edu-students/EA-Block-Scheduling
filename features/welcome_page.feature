Feature: Welcome Page Redirection

    Scenario: Redirecting a logged-in admin to the admin dashboard
        Given I am logged in as a test user
        When I visit the welcome page
        Then I should be redirected to the admin dashboard
        And I should see the notice "Welcome back!"

    Scenario: Not redirecting when the user is not logged in
        Given I am not logged in
        When I visit the welcome page
        Then I should remain on the welcome page

    Scenario: Redirecting a logged-in student to the student dashboard
        Given I am logged in as a student user
        When I visit the welcome page
        Then I should be redirected to the students dashboard
        And I should see the notice "Welcome back!"
