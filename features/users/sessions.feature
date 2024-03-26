@users @account
Feature: User sessions
  Background:
    Given user registers as name "yes", email "yes@examp.le" and password "123456"
    And user logs out

  Scenario: Logging in and out
    When user logs in with email "yes@examp.le" and password "123456"
    Then user should see "Select a chat to start messaging"
    And user should see "info" toast with text "Signed in successfully."
    When user logs out
    Then user should see "Log In"
    And user should see "info" toast with text "Signed out successfully."

  Scenario: Logging in with empty form
    When user logs in with email "" and password ""
    Then user should see "Log In"
    And user should see "danger" toast with text "Invalid Email or password."

  Scenario: Logging in with invalid email
    When user logs in with email "what" and password "123456"
    Then user should see "Log In"
    And user should see "danger" toast with text "Invalid Email or password."

  Scenario: Logging in with invalid password
    When user logs in with email "yes@examp.le" and password "what"
    Then user should see "Log In"
    And user should see "danger" toast with text "Invalid Email or password."
