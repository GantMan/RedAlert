module RubyMotionQuery

  # The new dual-purpose iOS 8 UIAlertControllerProvider
  class AlertControllerProvider

    attr_reader :alert_controller

    def build(actions, fieldset = nil, opts={})
      raise ArgumentError.new("At least 1 action is required.") unless actions && actions.length > 0
      @actions = actions
      @opts = opts

      # create our alert controller
      style = RubyMotionQuery::AlertConstants::ALERT_TYPES[@opts[:style]]
      @alert_controller = UIAlertController.alertControllerWithTitle @opts[:title], message:@opts[:message], preferredStyle: style

      # add our text fields and build up the callback hash
      @text_fields = {}
      if fieldset
        fieldset[:fields].each_with_index do |field, index|
          handler = lambda do |text_field|
            text_field.placeholder = field.placeholder
            text_field.secureTextEntry = field.secure_text_entry
            text_field.keyboardType = RubyMotionQuery::Stylers::KEYBOARD_TYPES[field.keyboard_type]
          end
          @alert_controller.addTextFieldWithConfigurationHandler(handler)
          @text_fields[field.name] = @alert_controller.textFields[index]
        end
      end


      # load up the UIAlertController's actions
      @actions.each do |alert_action|

        # convert the style
        ios_style = RubyMotionQuery::AlertConstants::ALERT_ACTION_STYLE[alert_action.style]

        # convert the callback
        handler = lambda do |action|
          alert_action.handler.call(alert_action.tag, @text_fields) unless alert_action.handler.nil?
        end if alert_action.handler

        # create the action
        action = UIAlertAction.actionWithTitle alert_action.title, style: ios_style, handler: handler

        # add it to the UIAlertController
        @alert_controller.addAction action
      end

      # popover
      if @opts[:style] == :sheet and rmq.device.ipad?
        raise ArgumentError.new "Please provide a :source view to use :sheet on iPad" unless @opts[:source]
        source = @opts[:source]
        @alert_controller.setModalPresentationStyle(UIModalPresentationPopover)
        if @opts[:modal]
          @alert_controller.setModalInPopover(true)
        end
        if source.is_a?(UIBarButtonItem)
          @alert_controller.popoverPresentationController.barButtonItem = source
        else
          @alert_controller.popoverPresentationController.sourceView = source
        end
        @alert_controller.popoverPresentationController.sourceRect = source.bounds
      end

      self
    end

    def show
      rmq.view_controller.presentViewController(@alert_controller, animated: @opts[:animated], completion: nil)
    end

  end
end
