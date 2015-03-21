module RubyMotionQuery
  class RMQ

    ALERT_TYPES = {
      alert: UIAlertControllerStyleAlert,
      sheet: UIAlertControllerStyleActionSheet
    }

    ALERT_ACTION_STYLE = {
      default: UIAlertActionStyleDefault,
      cancel: UIAlertActionStyleCancel,
      destructive: UIAlertActionStyleDestructive
    }


    # Creates and shows the UIAlertController.
    # Usage Example:
    #   rmq.alert(message: "This is a test")
    #   rmq.alert(title: "Hey there", message: "Are you happy?")
    # @return [RMQ]
    def alert(opts = {})

      if opts.is_a? String
        ok = ok_button do
          p "OK Pressed"
        end
        core_alert(message: opts, actions: [ok])
      else
        core_alert(opts)
      end

    end


    def core_alert(opts = {})
      # An alert is nothing without a message
      raise(ArgumentError, "RedPotion alert requires a message") unless opts[:message]

      opts = {
        title: "Alert!",
        style: :alert,
        actions: [],
        animated: true,
        show_now: true,
      }.merge(opts)


      # UIAlertController introduced in iOS8 only
      if rmq.device.ios_at_least? 8
        style = ALERT_TYPES[opts[:style]] || opts[:style]

        ac = UIAlertController.alertControllerWithTitle(opts[:title], message:opts[:message], preferredStyle: style)

        opts[:actions].each do |action|
          if action.is_a? UIAlertAction
            ac.addAction(action)
          elsif action.is_a? Hash
            p "Parse and use hash as action"
          else
            raise ArgumentError, "RedPotion alert actions must be of type UIAlertAction or Hash"
          end
        end

        # Present it, if that's what we want
        rmq.view_controller.presentViewController(ac, animated: opts[:animated], completion: nil) if opts[:show_now]

        # return it wrapped in RMQ
        rmq(ac)
      else
        alert_view(opts)
      end
    end

    def ok_button &block
      UIAlertAction.actionWithTitle("OK", style: UIAlertActionStyleDefault, handler: -> (action) {
        block.call
      })
    end


    # Creates and shows the old UIAlertView.  Added here for use in fallback.
    # Fallback won't run actions, but the old system needed delegates anyhow.
    # Usage Example:
    #   rmq.alert_view(message: "This is a test")
    #   rmq.alert_view(title: "Hey there", message: "Are you happy?")
    # @return [RMQ]
    def alert_view(opts = {})
      # An alert is nothing without a message
      raise(ArgumentError, "RedPotion alert requires a message") unless opts[:message]

      opts = {
        title: "Alert!",
        cancel_button: "OK",
        other_buttons: [],
        delegate: nil,
        view_style: UIAlertViewStyleDefault,
        show_now: true,
      }.merge(opts)

      alert_view = UIAlertView.alloc.initWithTitle(
        opts[:title],
        message: opts[:message],
        delegate: opts[:delegate],
        cancelButtonTitle: opts[:cancel_button],
        otherButtonTitles: nil
      )
      Array(opts[:other_buttons]).each { |button| alert_view.addButtonWithTitle(button) }

      alert_view.alertViewStyle = opts[:view_style]

      alert_view.show if opts[:show_now]
      rmq(alert_view)
    end

  end
end