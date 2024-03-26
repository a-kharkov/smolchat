@users @account
Feature: User registration
  In order to access the application
  User has to create an account

  Scenario: Go to registration form
    When user visits "/"
    And user clicks "New user?" link
    Then user should see "Sign Up"

  Scenario: Go back to Log In page
    When user visits "/users/sign_up"
    And user clicks "Already have an account?" link
    Then user should see "Log In"

  Scenario: Create valid user account
    When user registers as name "Cool Test Guy", email "cool@test.guy" and password "123456"
    Then user should see "Select a chat to start messaging"
    And user should see "info" toast with text "Welcome! You have signed up successfully."

  Scenario: User with such email already exists
    When user registers as name "Cool Test Guy", email "cool@test.guy" and password "123456"
    And user logs out
    When user registers as name "Cool Test Guy", email "cool@test.guy" and password "123456"
    Then user should see "Email has already been taken"

  Scenario: Submit invalid inputs
    When user registers as name "Cool$Test$Guy", email "cool$test.guy", password "123456" and password confirmation "1234567"
    Then user should see "Name format is invalid"
    And user should see "Email is invalid"
    And user should see "Password confirmation doesn't match Password"

  Scenario: Submit blank form
    When user registers as name "", email "" and password ""
    Then user should see "Name can't be blank"
    And user should see "Email can't be blank"
    And user should see "Password can't be blank"
