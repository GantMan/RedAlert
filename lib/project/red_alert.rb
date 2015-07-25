module RubyMotionQuery
  class App
    class << self

      TEMPLATE_FIELD_STYLES = [:input, :secure, :change_password, :login]
      ALL_FIELD_STYLES = TEMPLATE_FIELD_STYLES + [:custom]
      ALERT_STYLES = ALL_FIELD_STYLES + [:alert]
      VALID_STYLES = ALERT_STYLES + [:sheet]

      # Creates and shows the UIAlertController (iOS 8) or UIAlertView/UIActionSheet (iOS 7).
      # Usage Example:
      #   rmq.app.alert(message: "This is a test")
      #   rmq.app.alert(title: "Hey there", message: "Are you happy?")
      # @return [UIAlertController]
      def alert(opts={}, &block)

        # ------------------------------------
        # -- Setup sane defaults -------------
        # ------------------------------------
        opts           = {message: opts} if opts.is_a? String
        opts           = {style: :alert, animated: true, show_now: true}.merge(opts)
        opts[:message] = opts[:message] ? opts[:message].to_s : NSLocalizedString("Alert!", nil)

        style          = VALID_STYLES.include?(opts[:style]) ? opts[:style] : :alert
        # force the style to :sheet if :popover
        style          = :sheet if opts[:popover] and rmq.device.ipad?
        opts[:style]   = style
        opts[:fields]  = opts[:style] == :custom && opts[:fields] ? opts[:fields] : {text: {placeholder: ''}}
        api            = rmq.device.ios_at_least?(8) ? :modern : :deprecated
        api            = :deprecated if rmq.device.ios_at_least?(8) && opts[:api] == :deprecated
        opts[:api]     = api

        # -----------------------------------------
        # -- Who provides the alerts? -------------
        # -----------------------------------------

        if opts[:api] == :modern
          provider = AlertControllerProvider.new
        else
          if ALERT_STYLES.include?(opts[:style])
            provider = AlertViewProvider.new
          else
            provider = ActionSheetProvider.new
          end
        end

        # -------------------------------------------------
        # -- Configure the input fields --------------
        # -------------------------------------------------

        fieldset = {alert_view_style: UIAlertViewStyleDefault, fields: []}

        if TEMPLATE_FIELD_STYLES.include?(opts[:style])
          fieldset = add_template_fieldset(opts[:style])
        elsif opts[:style] == :custom
          fieldset = custom_fieldset(opts[:api], opts[:fields])
        end

        opts[:style] = :alert if ALL_FIELD_STYLES.include?(opts[:style])

        # -------------------------------------------------
        # -- Configure the actions (choices) --------------
        # -------------------------------------------------
        actions = []
        if opts[:actions] && opts[:actions].is_a?(Array) && opts[:actions].length > 0
          # caller has pre-defined actions
          actions << map_action_buttons(opts[:actions], &block)
        elsif opts[:actions] && opts[:actions].is_a?(Symbol)
          # caller wants a template
          actions << add_template_actions(opts[:actions], &block)
        elsif block_given?
          # convert our block into the one & only action
          actions << AlertAction.new(NSLocalizedString("OK", nil), &block)
        else
          # no actions & no block makes alerts a dull boy
          actions << [AlertAction.new(NSLocalizedString("OK", nil))]
        end
        provider.build(actions.flatten.compact, fieldset, opts)

        # --------------------------------------------
        # -- Show the modal right away? --------------
        # --------------------------------------------
        provider.show if opts[:show_now]

        # TODO: find a better way to do this ugly housekeeping... right now, this never gets cleaned, so this is leaky.
        if opts[:api] == :deprecated
          @rmq_red_alert_providers ||= []
          @rmq_red_alert_providers << provider
        end

        provider
      end # alert

      def custom_fieldset(api_version = :modern, fields)
        raise ArgumentError.new "At least one field must be provided for a custom style" unless fields && fields.count > 0
        fieldset = {alert_view_style: UIAlertViewStyleDefault, fields: [] }
        if api_version == :deprecated
          case fields.count
            when 1
              fieldset[:alert_view_style] = UIAlertViewStylePlainTextInput
            when 2
              fieldset[:alert_view_style] = UIAlertViewStyleLoginAndPasswordInput
            else
              raise ArgumentError.new "When running iOS < 8, up to two fields can be provided for a custom style"
          end
        end
        alert_fields = []
        fields.each do |k, v|
          alert_fields << AlertField.new(k, v)
        end
        fieldset[:fields] = alert_fields
        fieldset
      end

      # Returns an AlertField from given parameters
      # Usage Example:
      #   login = rmq.make_field("Login")
      #   password = rmq.make_field(:password, secure: true, placeholder: 'Password')
      # @return [AlertField]

      def make_field(name, opts={})
        AlertField.new(name, opts)
      end

      # Returns an AlertAction from given parameters
      # Usage Example:
      #   yes = rmq.make_button("Yes")
      #   cancel = rmq.make_button(title: "Cancel", style: :cancel) {
      #      puts "Cancel pressed"
      #   }
      # @return [AlertAction]
      def make_button(opts={}, &block)
        AlertAction.new(opts, &block)
      end

      # Returns an array of action buttons based on the symbols you pass in.
      # Usage Example:
      #   rmq.app.alert title: "Hey!", actions: [ "Go ahead", :cancel, :delete ] do |button_tag|
      #     puts "#{button_text} pressed"
      #   end
      def map_action_buttons(buttons, &block)
        yes    = NSLocalizedString("Yes", nil)
        no     = NSLocalizedString("No", nil)
        cancel = NSLocalizedString("Cancel", nil)
        ok     = NSLocalizedString("OK", nil)
        delete = NSLocalizedString("Delete", nil)

        buttons.map do |button|
          case button
          when :cancel  then make_button(title: cancel, tag: :cancel, style: :cancel, &block)
          when :yes     then make_button(title: yes, tag: :yes, &block)
          when :no      then make_button(title: no, tag: :no, &block)
          when :ok      then make_button(title: ok, tag: :ok, &block)
          when :delete  then make_button(title: delete, tag: :delete, style: :destructive, &block)
          when String   then make_button(title: button, tag: button, &block)
          else button
          end
        end
      end

    end # close eigenclass

  end # close App
end
