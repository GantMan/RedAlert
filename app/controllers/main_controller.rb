class MainController < UIViewController

  def viewDidLoad
    super

    self.title = 'redpotion_alert'

    rmq.stylesheet = MainStylesheet
    rmq(self.view).apply_style :root_view

    #Add buttons for different alert styles
    rmq.append(UIButton, :alert_view_button).on(:tap) do
      rmq.alert_view(message: "This is a test")
    end
  end

  def supportedInterfaceOrientations
    UIInterfaceOrientationMaskAll
  end
  def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
    rmq.all.reapply_styles
  end
end
