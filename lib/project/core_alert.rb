module RubyMotionQuery
  class App

    class << self
      # UIAlertController Magic
      def core_alert(opts = {}, &block)

        opts = {
          title: "Alert!",
          style: :alert,
          actions: [make_button(&block)],
          animated: true,
          show_now: true,
        }.merge(opts)
        style = RubyMotionQuery::AlertConstants::ALERT_TYPES[opts[:style]] || opts[:style]

        ac = UIAlertController.alertControllerWithTitle(opts[:title], message:opts[:message], preferredStyle: style)

        # Add correct actions (buttons) to the UIAC
        if opts[:actions].is_a? Symbol
          template_symbol = opts[:actions]
          add_template_actions(ac, template_symbol, &block)
        elsif opts[:actions].is_a? Array
          opts[:actions].each do |action|
            if action.is_a? UIAlertAction
              ac.addAction(action)
            else
              raise ArgumentError, "RedAlert actions array must contain UIAlertAction objects"
            end
          end
        else
          raise ArgumentError, "RedAlert actions parameter must be an Array or a Template symbol"
        end

        # Present it, if that's what we want
        rmq.view_controller.presentViewController(ac, animated: opts[:animated], completion: nil) if opts[:show_now]

        # return controller (should I wrap it in RMQ?)
        ac
      end
    end # close eigenclass

  end
end