class MainController < UIViewController

  def viewDidLoad
    super

    self.title = 'RedAlert'

    rmq.stylesheet = MainStylesheet
    rmq(self.view).apply_style :root_view

    # New UIAlertController Examples
    rmq.append(UIView, :alert_controller_section).tap do |acs|
      acs.append(UILabel, :alert_controller_title)

      # Simple alert example that has an OK button (RedAlert default),
      # doesn't care when it's pressed.
      acs.append(UIButton, :alert_controller_button).on(:tap) do
        rmq.alert("Minimal Alert")
      end

      # Alert example that has an OK button (RedAlert default),
      # puts a message when pressed.
      acs.append(UIButton, :alert_controller_two).on(:tap) do
        rmq.alert("Alert with Block") {
          puts "Alert with Block worked!"
        }
      end

      # Alert example with changed title and message.
      # OK button that doesn't care when pressed.
      acs.append(UIButton, :alert_controller_three).on(:tap) do
        rmq.alert(title: "New TITLE!", message: "So easy!")
      end

      # Simple action sheet example.
      # OK button that doesn't care when pressed.
      acs.append(UIButton, :alert_controller_four).on(:tap) do
        rmq.alert(title: "Hey there!", message: "My style is :sheet", style: :sheet)
      end

      ##############################
      #  Multiple button examples
      ##############################


      # Action sheet with template
      acs.append(UIButton, :alert_controller_five).on(:tap) do
        rmq.alert(message: "Would you like a sandwich?", actions: :yes_no_cancel, style: :sheet) { |action_type|
          case action_type
          when :yes
            p "yes"
          when :no
            p "no"
          end
        }
      end

      # Alert example with 4 buttons, each made with `make_button` helper.
      acs.append(UIButton, :alert_controller_six).on(:tap) do
        ok = rmq.make_button {
          p "OK pressed"
        }

        yes = rmq.make_button("Yes") {
          p "Yes pressed"
        }

        cancel = rmq.make_button(title: "Cancel", style: :cancel) {
          p "Cancel pressed"
        }

        destructive = rmq.make_button(title: "Destructive", style: :destructive) {
          p "Destructive pressed"
        }

        button_list = [ok, yes, cancel, destructive]

        rmq.alert(title: "Actions!", message: "Actions created with `make_button` helper.", actions: button_list)
      end

      # Example of loading the actions array with native UIAlertAction objects.
      acs.append(UIButton, :alert_controller_advanced_button).on(:tap) do

        ok = UIAlertAction.actionWithTitle("OK", style: UIAlertActionStyleDefault, handler: -> (action) {
          puts "#{action.title} was pressed"
        })

        cancel = UIAlertAction.actionWithTitle("Cancel", style: UIAlertActionStyleCancel, handler: -> (action) {
          puts "#{action.title} was pressed"
        })

        delete = UIAlertAction.actionWithTitle("Delete", style: UIAlertActionStyleDestructive, handler: -> (action) {
          puts "#{action.title} was pressed"
        })

        rmq.alert(title: "More Actions", message: "UIViewController 2", actions: [ok, cancel, delete])
      end

    end.resize_frame_to_fit_subviews(bottom: 10, right: -5)


    # Classic UIAlertView Examples
    rmq.append(UIView, :alert_view_section).tap do |avs|
      avs.append(UILabel, :alert_view_title)

      avs.append(UIButton, :alert_view_button).on(:tap) do
        rmq.alert_view("Minimal UIAlertView")
      end

      avs.append(UIButton, :alert_view_ks_button).on(:tap) do
        rmq.alert_view({
          title: "Hey There",
          message: "Check out this complex alert!",
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
