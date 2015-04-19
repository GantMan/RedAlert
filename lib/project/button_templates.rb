module RubyMotionQuery
  class App

    # When adding a new template do the following:
    # 1 - Add it here
    # 2 - Add the test
    # 3 - Add symbol to the README.md list
    def self.add_template_actions(uiac, template, &block)
      yes    = NSLocalizedString("Yes", nil)
      no     = NSLocalizedString("No", nil)
      cancel = NSLocalizedString("Cancel", nil)
      ok     = NSLocalizedString("OK", nil)
      delete = NSLocalizedString("Delete", nil)

      case template
      when :yes_no
        uiac.addAction(rmq.app.make_button(yes, &block))
        uiac.addAction(rmq.app.make_button(no, &block))
      when :yes_no_cancel
        uiac.addAction(rmq.app.make_button(yes, &block))
        uiac.addAction(rmq.app.make_button(no, &block))
        uiac.addAction(rmq.app.make_button({title: cancel, style: :cancel}, &block))
      when :ok_cancel
        uiac.addAction(rmq.app.make_button(ok, &block))
        uiac.addAction(rmq.app.make_button({title: cancel, style: :cancel}, &block))
      when :delete_cancel
        uiac.addAction(rmq.app.make_button({title: delete, style: :destructive}, &block))
        uiac.addAction(rmq.app.make_button({title: cancel, style: :cancel}, &block))
      end
    end

  end
end
