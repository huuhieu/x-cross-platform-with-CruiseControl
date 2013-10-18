#Begin Creating a new blog

Given /^I am about to create a new blog$/ do

  touch("button marked:'Create WordPress.com Blog'")

  wait_for_elements_do_not_exist(["activityIndicatorView"])



end

When /^I provide incomplete information$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I am presented with an error message to provide all information$/ do
  pending # express the regexp above with the code you wish you had
end

#END: Creating a new blog