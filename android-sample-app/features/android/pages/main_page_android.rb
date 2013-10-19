require 'calabash-android/abase'

class MainPage < Calabash::ABase

  def trait
    "org.wordpress.android.util.WPTitleBar"
  end

  def await
    wait_for_elements_exist([trait])
    wait_for_animation
    self
  end

  def show_menu
    unless menu_visible
      toggle_menu
      wait_for_animation
    end
  end

  def wait_for_blog_present(site)
    show_menu
    wait_for_elements_exist(["TextView id:'blog_title'"], :timeout => 20)
    site_name = query("textview id:'blog_title'", :text).first
    unless site_name == site
      screenshot_and_raise("Unable to see blog:#{site}, found:#{site_name}")
    end
  end


  def go_to_posts
    #assume on menu

    touch("* marked:'Posts'")
    wait_for(:timeout => 120,
             :retry_frequency => 1,
             :timeout_message => "Timed out waiting (120s) for 'Posts' screen") do

      headers = query("ListView LinearLayout index:0 TextView",:text)

      headers.include?"Posts" || element_exists("DialogText")
    end
  end

  def go_to_new_article
    @world.pending
  end

  def wait_for_article_to_appear(article)
    @world.pending
  end

  def assert_posts(posts)
    posts.each do |post|
      check_post_with_title_exists(post[:title])
      check_element_exists("ListView LinearLayout TextView {text BEGINSWITH '#{post[:date]}'}")
    end

  end


  def post_with_title(title)
    "ListView LinearLayout TextView text:'#{title}'"
  end

  def check_post_with_title_exists(title)
    check_element_exists(post_with_title(title))
  end

  def delete_top_article_if_matches(post)


  end


  def menu_visible
    element_exists("LinearLayout id:'dashboard_overlay'")
  end

  def toggle_menu
    touch("ImageButton marked:'home_small'")
  end


  def blog_site_selector(site)
    "label text:'#{site}'"
  end


end