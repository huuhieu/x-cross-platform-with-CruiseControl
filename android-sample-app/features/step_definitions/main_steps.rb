#BEGIN: Posts: login and view posts
Then /^I should see the "(.*?)" blog$/ do |site|
  @site = site

  @page.wait_for_blog_present(site)

  screenshot_embed(:label => "Blog: #{site}")
end


When /^I can see the blog posts in the Posts screen$/ do

  @page.go_to_posts

  @page.assert_posts(POSTS[:karl][0..1])

  screenshot_embed(:label => "Posts")


end

#END: Posts: login and view posts


#BEGIN: Posts: create new

#END: Posts: create new