require 'calabash-android/abase'

class WelcomePage < Calabash::ABase

  def trait
    "android.widget.Button marked:'Add blog hosted at WordPress.com'"
  end

  def wordpress_blog
    touch(trait)
    page(WordPressComPage).await
  end

  def await(opts={})

    begin
      r = performAction('assert_text', "GNU GENERAL PUBLIC LICENSE", false)
    rescue
      touch("android.widget.Button marked:'Accept'")
    end
    wait_for_elements_exist(["* {text BEGINSWITH 'Start blogging'}"])

    self
  end

end