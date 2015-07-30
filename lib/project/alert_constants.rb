module RubyMotionQuery
  module AlertConstants

    ALERT_TYPES = {
      alert: UIAlertControllerStyleAlert,
      sheet: UIAlertControllerStyleActionSheet
    }

    ALERT_ACTION_STYLE = {
      default: UIAlertActionStyleDefault,
      cancel: UIAlertActionStyleCancel,
      destructive: UIAlertActionStyleDestructive
    }

    ALERT_POPOVER_ARROW_DIRECTION = {
      up: UIPopoverArrowDirectionUp,
      down: UIPopoverArrowDirectionDown,
      left: UIPopoverArrowDirectionLeft,
      right: UIPopoverArrowDirectionRight,
      any: UIPopoverArrowDirectionAny
    }

  end
end
