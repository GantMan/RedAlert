module RubyMotionQuery

  # Brings the venerable iOS 7 AlertView to RedAlert.
  class AlertViewProvider

    attr_accessor :alert_view

    def build(actions, opts={})
      raise ArgumentError.new("At least 1 action is required.") unless actions && actions.length > 0
      @actions = actions
      @opts = opts

      # grab the first cancel action
      cancel_action = actions.find { |action| action.cancel? }

      # grab all the default & destructive buttons
      @actions_in_display_order = actions.find_all { |action| action.default? || action.destructive? }
      @actions_in_display_order << cancel_action if cancel_action

      # create a buttonless UIAlertView
      @alert_view = UIAlertView.alloc.initWithTitle @opts[:title], message: @opts[:message], delegate: self, cancelButtonTitle: nil, otherButtonTitles: nil

      # then bring in our buttons in order
      @actions_in_display_order.each { |action| @alert_view.addButtonWithTitle action.title }

      # mark where our special buttons are
      @alert_view.cancelButtonIndex = @actions_in_display_order.length-1 if cancel_action

      self
    end

    def show
      # NOTE: when we show, the view controller will disappear because a different _UIAlertOverlayWindow window will take its place
      @view_controller = rmq.view_controller
      @alert_view.show
    end

    private

    # fires when it is time to dismiss <UIAlertViewDelegate>
    def alertView(alertView, didDismissWithButtonIndex:buttonIndex)
      @view_controller.dismissViewControllerAnimated @opts[:animated], completion: nil
      action = @actions_in_display_order[buttonIndex]
      action.handler.call(action.tag) if action.handler
      @view_controller = nil # forget the reference
    end

  end

end
