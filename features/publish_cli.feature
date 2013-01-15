Feature: Publish draft CLI command
 Scenario: Publish a new blog draft article with the CLI
   Given a fixture app "drafts-app"
   And I run `middleman draft "My New Article"`
   And I run `middleman publish source/drafts/my-new-article.html.markdown --date 2012-03-07`
   Then the exit status should be 0
   And the following files should exist:
     | source/blog/2012-03-07-my-new-article.html.markdown |
   And the following files should not exist:
     | source/drafts/my-new-article.html.markdown |

  Scenario: Viewing a published article
   Given a fixture app "draft-date-app"
   And I run `middleman publish source/drafts/new-draft.html.erb --date 2012-03-07`
   When the Server is running at "draft-date-app"
   And I go to "/2012/03/07/new-draft.html"
   Then I should see '2012-03-07'
