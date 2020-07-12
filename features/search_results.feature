@search
Feature: Display on google shopping search results page

  Scenario: Check search results for dress are present on the page
    Given I am on google shopping search results page
    When I filter for dress
    Then I should see the dresses displayed

@sort
  Scenario: Sorting by REVIEW SCORE
  Given I am on google shopping search results page
  When I filter for dress
  Then I search by "REVIEW SCORE" value and should see the results sorted
