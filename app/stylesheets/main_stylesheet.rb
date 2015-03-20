class MainStylesheet < ApplicationStylesheet

  def root_view(st)
    st.background_color = color.white
  end

  def alert_view_section st
    st.frame = {bp: 20, w: screen_width - 5, centered: :horizontal}
    st.border_color = color.from_rgba(0,0,0,0.5)
    st.border_width = 1
    st.corner_radius = 5
    st.background_color = color.from_rgba(0, 0, 0, 0.2)
  end

  def alert_view_title st
    st.frame = {bp: 10, w: screen_width, h: 40}
    st.text_alignment = :centered
    st.number_of_lines = 2
    st.text = "UIAlertView Fallback (Deprecated)"
  end

  def alert_view_button st
    basic_button(st)
    st.text = "UIAlertView"
  end

  def alert_view_ks_button st
    basic_button(st)
    st.text = "UIAlertView Kitchen Sink"
  end

  def alert_controller_section st
    st.frame = {t: 75, w: screen_width - 5, centered: :horizontal}
    st.border_color = color.from_rgba(0,0,0,0.5)
    st.border_width = 1
    st.corner_radius = 5
    st.background_color = color.from_rgba(0, 0, 0, 0.2)
  end

  def alert_controller_title st
    st.frame = {bp: 10, w: screen_width, h: 40}
    st.text_alignment = :centered
    st.number_of_lines = 2
    st.text = "UIAlertController"
  end

  def alert_controller_button st
    basic_button(st)
    st.text = "UIAlertController"
  end

end
