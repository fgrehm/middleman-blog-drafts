Feature: Building the site
  Scenario: Unpublished articles don't get built
    Given a fixture app "drafts-app"
    When I run `middleman build`
    Then the build directory should be empty
