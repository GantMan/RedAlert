module RubyMotionQuery
  class RMQ

    # UIAlertController Magic
    def core_alert(opts = {}, &block)

      opts = {
        title: "Alert!",
        style: :alert,
        actions: [make_button(&block)],
        animated: true,
        show_now: true,
      }.merge(opts)
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
    end

  end
end