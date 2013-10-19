## Invalid login ##
Given /^I am about to login$/ do
  welcome = page(WelcomePage).await

  screenshot_embed(:label => 'Login') unless @disable_screenshot

  @page = welcome.wordpress_blog

end


When /^I enter invalid credentials$/ do
  @page = @page.login(USERS[:invalid])
  screenshot_embed


end

Then /^I am presented with an error message to correct credentials$/ do
  @page.assert_invalid_login_message
  screenshot_embed
end

## END: Invalid login ##



## Login and add blog ##

#noinspection CucumberDuplicatedStep
Given /^I am on the Welcome Screen$/ do
  @page = page(WelcomePage).await

  screenshot_embed
end

When /^I add the WordPress\.com blog$/ do
  @page = @page.wordpress_blog

  @page = @page.login(USERS[:karl])
end

Then /^I should be logged in$/ do
  if @page.is_a?(WordPressComPage)

    screenshot_embed

    raise "Was not logged in!"
  end

  screenshot_embed(:label => "Logged in")

end



## END: Login and add blog ##

def login_from_welcome_screen
  steps %Q{
    Given I am on the Welcome Screen
    When I add the WordPress.com blog
    Then I should be logged in
  }
end

Given /^I am logged in$/ do

  @disable_screenshot = true

  login_from_welcome_screen

  @disable_screenshot = false

end


#
#Then /^I should go to the recommended page$/ do
#  page(RecommendedPage).await(:timeout => 15)
#end
When /^the menu is visible$/ do
  @page.show_menu
  screenshot_embed(:label => "Menu") unless @disable_screenshot
end
