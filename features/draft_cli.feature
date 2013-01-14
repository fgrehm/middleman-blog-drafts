Feature: New draft CLI command
 Scenario: Create a new blog draft article with the CLI
   Given a fixture app "drafts-app"
   And I run `middleman draft "My New Article"`
   Then the exit status should be 0
   Then the following files should exist:
     | source/drafts/my-new-article.html.markdown |
