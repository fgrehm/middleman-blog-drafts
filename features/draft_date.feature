Feature: Derive draft date from today
  Scenario: Drafts without dates
    Given the Server is running at "draft-date-app"
    When I go to "/drafts/new-draft.html"
    Then I should see the current date
    When I go to "/drafts/other-draft.html"
    Then I should see the current date
