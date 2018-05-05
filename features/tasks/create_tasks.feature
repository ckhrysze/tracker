@domain @api
Feature: Creating tasks

  Rules
  - Tasks belong to projects
  - Tasks must have a name
  - Tasks start with status "todo"

  Scenario: Creating a task
    Given a project:
      | ID   | 54f8419c-3f22-4cba-b194-5f8b4727ccfd |
      | NAME | Sample Project                       |
    When I create a task with:
      | NAME        | Sample Task            |
      | DESCRIPTION | This is a sample task. |
      | STATUS      | todo                   |
    Then the project has a task with:
      | NAME        | STATUS |
      | Sample Task | todo   |
