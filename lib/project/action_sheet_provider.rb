module RubyMotionQuery

  # Brings the "I'm not dead yet" iOS 7 UIActionSheet to RedAlert.
  class ActionSheetProvider

    attr_reader :action_sheet

    def build(actions, fieldset=nil, opts={})
      raise ArgumentError.new "At least 1 action is required." unless actions && actions.length > 0
      @actions = actions
      @opts = opts

      raise ArgumentError.new "Please provide a :source view to use :sheet on iPad" if rmq.device.ipad? and !@opts[:source]

      # grab the first cancel action
      cancel_action = actions.find { |action| action.cancel? }

      # grab the first destructive action (UIActionSheet only supports one)
      destructive_action = actions.find { |action| action.destructive? }

      # let's put our actions in the correct display order for our callback
      @actions_in_display_order = actions.find_all { |action| action.default? }
      @actions_in_display_order << destructive_action if destructive_action
      @actions_in_display_order << cancel_action if cancel_action

      # create our action sheet
      @action_sheet = UIActionSheet.alloc.initWithTitle(
          @opts[:title] || @opts[:message],
          delegate: self,
          cancelButtonTitle: nil,
          destructiveButtonTitle: nil,
          otherButtonTitles: nil
          )

      # then append our other buttons in later
      @actions_in_display_order.each { |action| @action_sheet.addButtonWithTitle(action.title) }

      # mark where our special buttons are
      @action_sheet.destructiveButtonIndex = @actions_in_display_order.index { |action| action.destructive? } || -1
      @action_sheet.cancelButtonIndex = @actions_in_display_order.index { |action| action.cancel? } || -1

      self
    end

    def show
      # when we show, the view controller will disappear because a different _UIAlertOverlayWindow window will take its place
      @view_controller = rmq.view_controller

      if rmq.device.ipad?
        source = @opts[:source]
        if source.is_a?(UIBarButtonItem)
          @action_sheet.showFromBarButtonItem(source, animated: true)
        else
          @action_sheet.showFromRect(source.frame, inView: @view_controller.view, animated: true)
        end
      else
        @action_sheet.showInView(@view_controller.view)
      end
    end

    private

    # fires when we were dismissed <UIActionSheetDelegate>
    def actionSheet(actionSheet, didDismissWithButtonIndex:buttonIndex)
      # pull from the view controller instance
      @view_controller.dismissViewControllerAnimated @opts[:animated], completion: nil
      action = @actions_in_display_order[buttonIndex]
      action.handler.call(action.tag, nil) if action.handler
      @view_controller = nil # forget the reference
    end

  end

end
