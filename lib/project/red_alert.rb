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
    def alert(opts = {}, &block)
      opts = {message: opts} if opts.is_a? String
      core_alert(opts, &block)
    end


    def core_alert(opts = {}, &block)
      # An alert is nothing without a message
      raise(ArgumentError, "RedAlert alert requires a message") unless opts[:message]

      opts = {
        title: "Alert!",
        style: :alert,
        actions: [make_button(&block)],
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
            raise ArgumentError, "RedAlert actions must be of type UIAlertAction or Hash"
          end
        end

        # Present it, if that's what we want
        rmq.view_controller.presentViewController(ac, animated: opts[:animated], completion: nil) if opts[:show_now]

        # return it wrapped in RMQ
        rmq(ac)
      else
        raise "RedAlert requires iOS8 for alerts.  Please try `rmq.alert_view`"
      end
    end

    def make_button (opts = {}, &block)
      # shortcut sending a string
      opts = {title: opts} if opts.is_a? String

      opts = {
        title: "OK",
        style: :default,
      }.merge(opts)

      style = ALERT_ACTION_STYLE[opts[:style]] || opts[:style]

      UIAlertAction.actionWithTitle(opts[:title], style: style, handler: -> (action) {
        title_symbol = action.title.gsub(/\s+/,"_").downcase.to_sym
        block.call(title_symbol) unless block.nil?
      })
    end

  end
end