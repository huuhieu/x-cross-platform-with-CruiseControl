#BEGIN:Create new posts

Given /^I'm on the New Post screen$/ do

  @page.go_to_posts
  @page = @page.go_to_new_article

  screenshot_embed(:label => "New Post")
end

When /^I post an article$/ do


  @article = POSTS[:new]
  @page = @page.publish_article(@article)
  screenshot_embed(:label => "Publish")

end

Then /^the article should be visible in the Posts screen$/ do

  @page.wait_for_article_to_appear(@article)
  screenshot_embed(:label => "Published article")

end

#END:Create new posts


