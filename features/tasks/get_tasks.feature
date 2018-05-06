@api
Feature: Get task


  Scenario: Get a specific task
    Given a project
    And that project has tasks:
      | ID                                   | NAME   | STATUS |
      | 54f8419c-3f22-4cba-b194-5f8b4727ccfd | getter | todo   |
    When I request the task "54f8419c-3f22-4cba-b194-5f8b4727ccfd"
    Then I get the data:
      """
      {
      id: '54f8419c-3f22-4cba-b194-5f8b4727ccfd',
      name: 'getter',
      description: '',
      status: 'todo'
      }
      """
