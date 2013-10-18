require 'calabash-cucumber/ibase'

class NewArticlePage < Calabash::IBase

  def title
    'New Post'
  end

  def publish_article(article)
    touch("view marked:'Title:'", :offset => {:x => 200})
    wait_for_animation

    keyboard_enter_text(article[:title])
    done
    wait_for_animation

    touch("label text:'Tap here to begin writing'")


    keyboard_enter_text(article[:body])

    screenshot_embed(:label => 'New Article text')

    touch("button marked:'Done'")
    wait_for_animation

    transition(:tap => "button marked:'Publish'",
               :page => MainPage)
  end


end