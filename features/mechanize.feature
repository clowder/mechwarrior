@mechanize
Feature: an entire feature that uses mechanize

  Scenario: should use mechanize without being explicitly told
    Then Capybara should use the "mechanize" driver
