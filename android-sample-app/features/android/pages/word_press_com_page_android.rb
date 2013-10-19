require 'calabash-android/abase'

class WordPressComPage < Calabash::ABase

  def trait
    "* id:'username'"
  end

  def await(opts={})
    wait_for_elements_exist([trait])
    self
  end


  def login(user)
    query("* id:'username'",{:setText => user[:email]})
    query("* id:'password'",{:setText => user[:password]})

    performAction('scroll_down')

    touch(login_button_query)

    sleep(1)#Chance to show Dialog

    wait_for(:timeout => 60, :timeout_message => "Timed out logging in") do
      current_dialogs = query("DialogTitle",:text)

      empty_dialog = current_dialogs.empty?
      error_dialog = current_dialogs.include?("Error")
      no_network_dialog = current_dialogs.include?("No network available")

      empty_dialog or error_dialog or no_network_dialog
    end
    sleep(1) # chance to transition

    main_page = page(MainPage)

    if main_page.current_page?
      main_page.await
    else
      self
    end
  end

  def invalid_login_query
    login_button_query
  end

  def login_button_query
    "android.widget.Button marked:'Log In'"
  end

  def assert_invalid_login_message
    check_element_exists(invalid_login_query)
  end


end