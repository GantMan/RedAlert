module RubyMotionQuery
  class App

    # When adding a new template do the following:
    # 1 - Add it here
    # 2 - Add the test
    # 3 - Add symbol to the README.md list


    def self.add_template_actions(template, &block)
      yes    = NSLocalizedString("Yes", nil)
      no     = NSLocalizedString("No", nil)
      cancel = NSLocalizedString("Cancel", nil)
      ok     = NSLocalizedString("OK", nil)
      delete = NSLocalizedString("Delete", nil)

      case template
      when :yes_no
        [
          rmq.app.make_button(title: yes, tag: :yes, &block),
          rmq.app.make_button(title: no, tag: :no, &block)
        ]
      when :yes_no_cancel
        [
          rmq.app.make_button(title: yes, tag: :yes, &block),
          rmq.app.make_button(title: no, tag: :no, &block),
          rmq.app.make_button(title: cancel, tag: :cancel, style: :cancel, &block)
        ]
      when :ok_cancel
        [
          rmq.app.make_button(title: ok, &block),
          rmq.app.make_button(title: cancel, tag: :cancel, style: :cancel, &block)
        ]
      when :delete_cancel
        [
          rmq.app.make_button(title: delete, tag: :delete, style: :destructive, &block),
          rmq.app.make_button(title: cancel, tag: :cancel, style: :cancel, &block)
        ]
      else
        []
      end
    end

  end
end
