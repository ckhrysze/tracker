@domain @api
Feature: Listing tasks

  Rules
  - if a negative page is requested, an error is thrown
  - if a page that is too high is requested, the last page is returned
  - if a negative page_size is requested, the default size is used


  Scenario: No parameters are specified and there are 12 tasks
    Given a project
    And that project has 12 tasks
    When I request the project's tasks
    Then I get 10 tasks back
    And the current page is 1
    And the total pages is 2
    And the total results is 12


  Scenario: Verifying the format shape
    Given a project
    And that project has tasks:
      | ID                                   | NAME   | STATUS      |
      | 54f8419c-3f22-4cba-b194-5f8b4727ccfd | first  | todo        |
      | 54f8419c-3f22-4cba-b194-5f8b4727ccfe | second | in-progress |
      | 54f8419c-3f22-4cba-b194-5f8b4727ccff | third  | done        |
    When I request the project's tasks
    Then I get the data:
      """
      {
      tasks: [
      {
      id: '54f8419c-3f22-4cba-b194-5f8b4727ccfd',
      name: 'first',
      description: '',
      status: 'todo'
      },
      {
      id: '54f8419c-3f22-4cba-b194-5f8b4727ccfe',
      name: 'second',
      description: '',
      status: 'in-progress'
      },
      {
      id: '54f8419c-3f22-4cba-b194-5f8b4727ccff',
      name: 'third',
      description: '',
      status: 'done'
      }
      ],
      count: 3,
      current_page_number: 1,
      total_page_count: 1
      }
      """
