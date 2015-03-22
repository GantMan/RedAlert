module RubyMotionQuery
  module ButtonTemplates

    # add_template_actions(ac, template_symbol, &block)
    def add_template_actions(uiac, template, &block)
      case template
      when :yes_no_cancel
        uiac.addAction(rmq.make_button("Yes", &block))
        uiac.addAction(rmq.make_button("No", &block))
        uiac.addAction(rmq.make_button({title: "Cancel", style: :cancel}, &block))
      end
    end

  end
end