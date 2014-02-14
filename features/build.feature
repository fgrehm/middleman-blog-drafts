Feature: Building the site

  Scenario: Default config builds only drafts with frontmatter build=true
    Given a fixture app "drafts-app"
    When I run `middleman build`
    Then the following files should not exist:
      | build/drafts/new-draft.html |
    And the following files should exist:
      | build/drafts/draft-build-true.html |

  Scenario: Config build=true does not build drafts with frontmatter build=false
    Given a fixture app "drafts-build-true-app"
    When I run `middleman build`
    Then the following files should exist:
      | build/drafts/new-draft.html |
    And the following files should not exist:
      | build/drafts/draft-build-false.html |
