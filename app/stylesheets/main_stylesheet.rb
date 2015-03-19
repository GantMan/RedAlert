class MainStylesheet < ApplicationStylesheet

  def root_view(st)
    st.background_color = color.white
  end

  def alert_view_button st
    basic_button(st)
    st.text = "UIAlertView (Deprecated)"
  end

end
