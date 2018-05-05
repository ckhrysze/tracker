@domain @api
Feature: Transitioning tasks

  Rules
  - task starts with status todo
  - todo can only transition to in progress
  - in progress can transition to either todo or done
  - status transitions are over once status is done


  Scenario: Transition task to in progress
    Given a project
    And that project has a task "first"
    When I transition the task to "in_progress"
    Then the task has details:
      | NAME   | first       |
      | STATUS | in_progress |


  Scenario: Transition task to done
    Given a project
    And that project has a task "second"
    When I transition the task to "in_progress"
    And I transition the task to "done"
    Then the task has details:
      | NAME   | second |
      | STATUS | done   |
    And I receive a text message


  Scenario: Transition task directly to done
    Given a project
    And that project has a task "too fast"
    And I transition the task to "done"
    Then I get a status error


  Scenario: Transition task to todo from done
    Given a project
    And that project has a task "done is done"
    When I transition the task to "in_progress"
    And I transition the task to "done"
    And I transition the task to "todo"
    Then I get a status error


  Scenario: Transition task to in progress from done
    Given a project
    And that project has a task "done is done"
    When I transition the task to "in_progress"
    And I transition the task to "done"
    And I transition the task to "in_progress"
    Then I get a status error
