Feature: Capybara's cucumber integration
  In order to integrate with the lovely plain text testing framework
  As Capybara
  I want to integrate successfully with Cucumber

  Scenario: hello world
    When I visit the root page
    Then I should see "Hello world!"

  @external
  Scenario: external tag
    When I visit the root page
    Then Capybara should use the "mechanize" driver

  @mechanize
  Scenario: mechanize tag
    When I visit the root page
    Then Capybara should use the "mechanize" driver

  @mechanize
  Scenario Outline: mechanize tag with scenario outline
    When I visit the <Page> page
    Then Capybara should use the "mechanize" driver

    Examples:
      | Page |
      | root |
      | home |

  Scenario: matchers
    When I visit the root page
    And I use a matcher that fails
    Then the failing exception should be nice
