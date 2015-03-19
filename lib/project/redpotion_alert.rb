module RubyMotionQuery
  class RMQ

    ALERT_TYPES = {
      alert: UIAlertControllerStyleAlert,
      sheet: UIAlertControllerStyleActionSheet
    }

    # Creates and shows the old UIAlertView.
    # Usage Example:
    #   rmq.alert_view(message: "This is a test")
    #   rqm.alert_view(title: "Hey there", message: "Are you happy?")
    # @return [RMQ]
    def alert_view(opts = {})
      # An alert is nothing without a message
      raise ArgumentError unless opts[:message]

      opts = {
        title: "Alert!",
        cancel_button: "OK",
        other_buttons: [],
        delegate: nil,
        view_style: UIAlertViewStyleDefault,
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

      alert_view.show
      rmq(alert_view)
    end

# UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
#                                message:@"This is an alert."
#                                preferredStyle:UIAlertControllerStyleAlert];



    def alert(opts = {})
      # UIAlertController introduced in iOS8 only
      if rmq.device.ios_at_least? 8

      else
        alert_view(opts)
      end
    end
  end
end