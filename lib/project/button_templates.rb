module RubyMotionQuery
  class App

    # When adding a new template do the following:
    # 1 - Add it here
    # 2 - Add the test
    # 3 - Add symbol to the README.md list
    def self.add_template_actions(uiac, template, &block)
      case template
      when :yes_no
        uiac.addAction(rmq.app.make_button("Yes", &block))
        uiac.addAction(rmq.app.make_button("No", &block))
      when :yes_no_cancel
        uiac.addAction(rmq.app.make_button("Yes", &block))
        uiac.addAction(rmq.app.make_button("No", &block))
        uiac.addAction(rmq.app.make_button({title: "Cancel", style: :cancel}, &block))
      when :ok_cancel
        uiac.addAction(rmq.app.make_button("OK", &block))
        uiac.addAction(rmq.app.make_button({title: "Cancel", style: :cancel}, &block))
      when :delete_cancel
        uiac.addAction(rmq.app.make_button({title: "Delete", style: :destructive}, &block))
        uiac.addAction(rmq.app.make_button({title: "Cancel", style: :cancel}, &block))
      end
    end

  end
end