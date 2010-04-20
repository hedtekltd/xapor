Feature:
  In order to search models
  I need to add search functionality to a model with xapor

  Scenario: Adding xapor searching to an object
    Given I have a model object with "name"
    When I call xapor to index "name"
    Then I should have a "search" class function
    And I should have a "search_by_name" class function

  Scenario: Searching with xapor
    Given I have a xapor model object with a name
    And I have a xapor model with name "Testing"
    And I have a xapor model with name "Awesome"
    When I search the model for "Testing"
    Then I should get 1 result
    And I should have a result with name "Testing"
