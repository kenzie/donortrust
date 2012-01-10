@no-txn
Feature: Projects total cost count
  In order to find projects by total cost
  As a user with an account
  I want to be able to search for projects by total cost

  Background: logged in
    Given I am an authenticated user
    And there is a project "Small Project" with total cost of $2500
    And there is a project "Medium Project 1" with total cost of $6000
    And there is a project "Medium Project 2" with total cost of $8000
    And there is a project "Large Project" with total cost of $12000
    And the project indexes are processed

  Scenario: Project total cost counts
    Given I am on the projects page
    Then I should see "$0 - $5,000" within ".project-filter"
    And I should see "$5,001 - $10,000" within ".project-filter"
    And I should see "$10,001 - $15,000" within ".project-filter"
