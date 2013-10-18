require 'calabash-cucumber/ibase'

class WordPressComPage < Calabash::IBase

  def title
    "Sign In"
  end

  def login(user)
     touch("view marked:'Username'")
     await_keyboard

     keyboard_enter_text user[:email]

     touch("view marked:'Password'")

     keyboard_enter_text user[:password]
     done

     wait_for_elements_do_not_exist(["tableViewCell activityIndicatorView"],
                                    :timeout => 120)


     if element_exists(invalid_login_query)
      self
     else
      page(MainPage).await
     end
  end

  def assert_invalid_login_message
    check_element_exists(trait)
    check_element_exists(invalid_login_query)
  end

  def invalid_login_query
    "label {text LIKE '*Sign in failed*'}"
  end

end