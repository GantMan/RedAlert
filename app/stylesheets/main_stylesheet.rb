class MainStylesheet < ApplicationStylesheet

  def root_view(st)
    st.background_color = color.white
  end

  def alert_view_buttons st
    st.frame = {t: 75, w: screen_width - 5, centered: :horizontal}
    st.border_color = color.black
    st.border_width = 3
    st.corner_radius = 5
    st.background_color = color.from_rgba(0, 0, 0, 0.3)
  end

  def alert_view_button st
    basic_button(st)
    st.text = "UIAlertView"
  end

  def alert_view_ks_button st
    basic_button(st)
    st.text = "UIAlertView Kitchen Sink"
  end

end
