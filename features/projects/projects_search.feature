@no-txn
Feature: Projects search
  In order to find projects
  As a user with an account
  I want to be able to search and filter projects

  Background: logged in
    Given I am an authenticated user
    And the following projects
    | name                | total_cost  | country      | partner        | sector      |
    | Small Project       | 2500        | Turbekistan  | Tag Solutions  | Education   |
    | Medium Project 1    | 6000        | Turbekistan  | Tag Solutions  | Education   |
    | Medium Project 2    | 6000        | Turbekistan  | Tag Solutions  | Health      |
    | Large Project       | 12000       | Cape Breton  | Tag Solutions  | Health      |
    And the project indexes are processed

  Scenario: Project filters
    Given I am on the projects page
    Then I should see "Active (4)"
    And I should see "Health (2)"
    And I should see "Education (2)"
    And I should see "Turbekistan (3)"
    And I should see "Tag Solutions (4)"
    And I should see "$0 - $5,000 (1)" within ".project-filter"
    And I should see "$5,001 - $10,000 (2)" within ".project-filter"
    And I should see "$10,001 - $15,000 (1)" within ".project-filter"

  Scenario: Status results count
    Given I am on the projects page
    And I follow "Active (4)"
    Then I should see 4 projects listed
    And I should see "Small Project"

  Scenario: Sector results count
    Given I am on the projects page
    And I follow "Health (2)"
    Then I should see 2 projects listed
    And I should see "Medium Project 2"
    And I should not see "Small Project"

  Scenario: Location results count
    Given I am on the projects page
    And I follow "Turbekistan (3)"
    Then I should see 3 projects listed
    And I should see "Small Project"
    And I should not see "Large Project"

  Scenario: Partner results count
    Given I am on the projects page
    And I follow "Tag Solutions (4)"
    Then I should see 4 projects listed
    And I should see "Small Project"

  Scenario: Cost results count
    Given I am on the projects page
    And I follow "$5,001 - $10,000 (2)"
    Then I should see 2 projects listed
    And I should see "Medium Project 1"
    And I should not see "Large Project"
