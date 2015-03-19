class MainController < UIViewController

  def viewDidLoad
    super

    self.title = 'redpotion_alert'

    rmq.stylesheet = MainStylesheet
    rmq(self.view).apply_style :root_view

    #Add buttons for different alert styles
    rmq.append(UIView, :alert_view_section).tap do |avb|
      avb.append(UILabel, :alert_view_title)

      avb.append(UIButton, :alert_view_button).on(:tap) do
        rmq.alert_view(message: "This is a test")
      end

      avb.append(UIButton, :alert_view_ks_button).on(:tap) do
        rmq.alert_view({
          title: "Hey There",
          message: "This is a test",
          cancel_button: 'Nevermind',
          other_buttons: ['Log In'],
          delegate: nil,
          view_style: UIAlertViewStyleLoginAndPasswordInput
        })
      end
    end.resize_frame_to_fit_subviews(bottom: 10, right: -5)
  end

  def supportedInterfaceOrientations
    UIInterfaceOrientationMaskAll
  end
  def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
    rmq.all.reapply_styles
  end
end
