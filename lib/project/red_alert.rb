module RubyMotionQuery
  class App
    class << self

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
        opts[:style]   = :alert unless opts[:style] == :sheet
        api            = rmq.device.ios_at_least?(8) ? :modern : :deprecated
        api            = :deprecated if rmq.device.ios_at_least?(8) && opts[:api] == :deprecated
        opts[:api]     = api

        # -----------------------------------------
        # -- Who provides the alerts? -------------
        # -----------------------------------------
        if opts[:api] == :modern
          provider = AlertControllerProvider.new
        else
          if opts[:style] == :alert
            provider = AlertViewProvider.new
          else
            provider = ActionSheetProvider.new
          end
        end

        # -------------------------------------------------
        # -- Configure the actions (choices) --------------
        # -------------------------------------------------
        actions = []
        if opts[:actions] && opts[:actions].is_a?(Array) && opts[:actions].length > 0
          # caller has pre-defined actions
          actions << opts[:actions]
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
        provider.build(actions.flatten.compact, opts)

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

      # Returns a UIAlertAction from given parameters
      # Usage Example:
      #   yes = rmq.make_button("Yes")
      #   cancel = rmq.make_button(title: "Cancel", style: :cancel) {
      #      puts "Cancel pressed"
      #   }
      # @return [UIAlertAction]
      def make_button(opts={}, &block)
        AlertAction.new(opts, &block)
      end

    end # close eigenclass

  end # close App
end
