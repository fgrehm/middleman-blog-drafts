Feature: Listing drafts
  Scenario: Draft articles can be listed
    Given the Server is running at "drafts-app"
    When I go to "/drafts/listing_drafts.html"
    Then I should see "New Draft Title"
    And I should see "Other Draft Title"
    And I should see "Drafts List"
