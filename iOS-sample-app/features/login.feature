Feature: Login
  As a user I'll be able to add wordpress hosted blogs. To authenticate,
  I'll provide email and password. I'll see appropriate error messages
  if I enter a bad username and password combination.

  @invalid_login
  Scenario: Invalid login to WordPress.com blog
    Given I am about to login
    When I enter invalid credentials
    Then I am presented with an error message to correct credentials


  @add_blog
  Scenario: Adding a WordPress.com blog
    Given I am on the Welcome Screen
    When I add the WordPress.com blog
    Then I should be logged in
