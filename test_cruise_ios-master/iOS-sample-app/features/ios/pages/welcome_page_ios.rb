require 'calabash-cucumber/ibase'

class WelcomePage < Calabash::IBase

  def trait
    "button marked:'Add WordPress.com Blog'"
  end

  def wordpress_blog
    transition(:tap => trait, :page => WordPressComPage)
  end

end