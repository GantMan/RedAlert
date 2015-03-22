class MainController < UIViewController

  def viewDidLoad
    super

    self.title = 'RedAlert'

    rmq.stylesheet = MainStylesheet
    rmq(self.view).apply_style :root_view

    rmq.append(UIScrollView, :containing_scroller).tap do |cs|

      # New UIAlertController Examples
      cs.append(UIView, :alert_controller_section).tap do |acs|
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
        # OK button that prints the button's action_type
        acs.append(UIButton, :alert_controller_three).on(:tap) do
          rmq.alert(title: "New TITLE!", message: "So easy!") do |action_type|
            puts "you clicked #{action_type}"
          end
        end

        # Simple action sheet example.
        # OK button that doesn't care when pressed.
        acs.append(UIButton, :alert_controller_four).on(:tap) do
          rmq.alert(title: "Hey there!", message: "My style is :sheet", style: :sheet)
        end

        ##############################
        #  Multiple button examples
        ##############################

        # Action sheet with ease of the template
        acs.append(UIButton, :alert_controller_five).on(:tap) do
          rmq.alert(message: "Would you like a sandwich?", actions: :yes_no_cancel, style: :sheet) do |title|
            case title
            when :yes
              puts "Here's your Sandwich!"
            when :no
              puts "FINE!"
            end
          end
        end

        acs.append(UIButton, :alert_controller_six).on(:tap) do
         rmq.alert(title: "DESTROY!!!", message: "Would you like to remove some important data?", actions: :delete_cancel) do |title|
            case title
            when :delete
              puts "Destroying that data!"
            when :cancel
              puts "keep all the things!"
            end
          end
        end

        # Alert example with 4 buttons, each made with `make_button` helper.
        acs.append(UIButton, :alert_controller_seven).on(:tap) do
          ok = rmq.make_button {
            puts "OK pressed"
          }

          yes = rmq.make_button("Yes") {
            puts "Yes pressed"
          }

          cancel = rmq.make_button(title: "Cancel", style: :cancel) {
            puts "Cancel pressed"
          }

          destructive = rmq.make_button(title: "Destructive", style: :destructive) {
            puts "Destructive pressed"
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
      cs.append(UIView, :alert_view_section).tap do |avs|
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

    end.resize_content_to_fit_subviews
  end

  def supportedInterfaceOrientations
    UIInterfaceOrientationMaskAll
  end
  def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
    rmq.all.reapply_styles
  end
end
