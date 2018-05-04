@domain @api
Feature: Creating projects

  Rules
  - Name is required
  - Created projects should default to "active" state

  Scenario: Creating a project with all fields
    When I create a project with:
      | NAME        | Sample Project            |
      | DESCRIPTION | This is a sample project. |
      | STATE       | active                    |
    Then the system has the projects:
      | NAME           | STATE  |
      | Sample Project | active |


  Scenario: Trying to create a project without a name
    When I try to create a project with:
      | DESCRIPTION | This is a sample project. |
      | STATE       | active                    |
    Then the system has 0 projects
    And I get the error "Name can't be blank"
