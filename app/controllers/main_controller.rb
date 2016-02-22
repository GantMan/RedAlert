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
        acs.append(UILabel, :usage_tour)

        # Simple alert example that has an OK button (RedAlert default),
        # doesn't care when it's pressed.
        acs.append(UIButton, :alert_controller_button).on(:tap) do
          rmq.app.alert("Minimal Alert")
        end

        # Alert example that has an OK button (RedAlert default),
        # puts a message when pressed.
        acs.append(UIButton, :alert_controller_two).on(:tap) do
          rmq.app.alert("Alert with Block") {
            puts "Alert with Block worked!"
          }
        end

        # Alert example with changed title and message.
        # OK button that prints the button's action_type
        acs.append(UIButton, :alert_controller_three).on(:tap) do
          rmq.app.alert(title: "New TITLE!", message: "So easy!") do |action_type|
            puts "you clicked #{action_type}"
          end
        end

        # Simple action sheet example.
        # OK button that doesn't care when pressed.
        acs.append(UIButton, :alert_controller_four).on(:tap) do |sender|
          rmq.app.alert(title: "Hey there!", message: "My style is :sheet", style: :sheet, source: sender) do |action_type|
            puts "you clicked #{action_type}"
          end
        end

        # Sheet with no message
        acs.append(UIButton, :alert_controller_no_message).on(:tap) do |sender|
          rmq.app.alert(message: nil, style: :sheet, actions: :yes_no_cancel, source: sender) do |action_type|
            puts "you clicked #{action_type}"
          end
        end

        ##############################
        #  Field examples
        ##############################

        # Text field example with :input style.
        acs.append(UIButton, :alert_controller_fields_one).on(:tap) do
          rmq.app.alert(title: "Text Field", message: "My style is :input", style: :input) do |action_type, fields|
            puts "you entered '#{fields[:text].text}'"
          end
        end

        # Text field example with :input style and placeholder.
        acs.append(UIButton, :alert_controller_fields_two).on(:tap) do
          rmq.app.alert(title: "Text Field", message: "My style is :input", style: :input, placeholder: "Some Placeholder") do |action_type, fields|
            puts "you entered '#{fields[:text].text}'"
          end
        end

        # Text field example with :input style and text pre-set
        acs.append(UIButton, :alert_controller_fields_three).on(:tap) do
          rmq.app.alert(title: "Text Field", message: "My style is :input", style: :input, text: "Some Text", placeholder: "Some Placeholder") do |action_type, fields|
            puts "you entered '#{fields[:text].text}'"
          end
        end

        # Text field example with :secure style.
        acs.append(UIButton, :alert_controller_fields_four).on(:tap) do
          rmq.app.alert(title: "Text Field", message: "My style is :secure", style: :secure) do |action_type, fields|
            puts "you entered '#{fields[:text].text}'"
          end
        end

        # Text field example with :login style.
        acs.append(UIButton, :alert_controller_fields_five).on(:tap) do
          rmq.app.alert(title: "Text Field", message: "My style is :login", style: :login) do |action_type, fields|
            puts "you entered '#{fields[:login].text}' as the login and '#{fields[:password].text}' as the password"
          end
        end

        # Text field example with :change_password style.
        acs.append(UIButton, :alert_controller_fields_six).on(:tap) do
          rmq.app.alert(title: "Text Field", message: "My style is :change_password", style: :change_password) do |action_type, fields|
            puts "you entered '#{fields[:current_password].text}' as the current password and '#{fields[:new_password].text}' as the new password"
          end
        end

        # Text field example with :custom style.
        acs.append(UIButton, :alert_controller_fields_seven).on(:tap) do
          rmq.app.alert(title: "Text Field", message: "My style is :custom", style: :custom, fields:
                       {phone: {placeholder: 'Phone', keyboard_type: :phone_pad},
                        email: {placeholder: 'Email', secure: false, keyboard_type: :email_address}}) do |action_type, fields|
            puts "you entered '#{fields[:phone].text}' and '#{fields[:email].text}'"
          end
        end

        ##############################
        #  Multiple button examples
        ##############################


        # Alert example with 4 buttons, each made with `make_button` helper.
        acs.append(UIButton, :custom_actions_helper_alert).on(:tap) do
          ok = rmq.app.make_button {
            puts "OK pressed"
          }

          yes = rmq.app.make_button("Yes") {
            puts "Yes pressed"
          }

          cancel = rmq.app.make_button(title: "Cancel", style: :cancel) {
            puts "Cancel pressed"
          }

          destructive = rmq.app.make_button(title: "Destructive", style: :destructive) {
            puts "Destructive pressed"
          }

          button_list = [ok, yes, cancel, destructive]

          rmq.app.alert(title: "Actions!", message: "Actions created with `make_button` helper.", actions: button_list)
        end

        # Alert example with 4 buttons, each made with `make_button` helper.
        acs.append(UIButton, :custom_actions_helper_sheet).on(:tap) do |sender|
          ok = rmq.app.make_button {
            puts "OK pressed"
          }

          yes = rmq.app.make_button("Yes") {
            puts "Yes pressed"
          }

          cancel = rmq.app.make_button(title: "Cancel", style: :cancel) {
            puts "Cancel pressed"
          }

          destructive = rmq.app.make_button(title: "Destructive", style: :destructive) {
            puts "Destructive pressed"
          }

          button_list = [ok, yes, cancel, destructive]

          rmq.app.alert(title: "Actions!", message: "Actions created with `make_button` helper.", actions: button_list, style: :sheet, source: sender)
        end

        # Alert from popover
        acs.append(UIButton, :alert_from_popover).on(:tap) do |sender|
          label = rmq.find(:template_tour).get
          label.sizeToFit
          rmq.app.alert(title: "Popover", message: "Presented from popover (if iPad)", actions: [:ok], style: :sheet, source: label, arrow_direction: [:left,:right])
        end if rmq.device.ipad?

        acs.append(UILabel, :template_tour)


        # Action sheet with ease of the template
        acs.append(UIButton, :alert_controller_yesno).on(:tap) do
          rmq.app.alert(message: "Would you use Templates?", actions: :yes_no) do |title|
            case title
            when :yes
              puts "They are so easy!"
            when :no
              puts "No worries, we can build custom."
            end
          end
        end

        acs.append(UIButton, :alert_controller_yesnocancel).on(:tap) do |sender|
          rmq.app.alert(message: "Would you like a sandwich?", actions: :yes_no_cancel, style: :sheet, source: sender) do |title|
            case title
            when :yes
              puts "Here's your Sandwich!"
            when :no
              puts "FINE!"
            when :cancel
              puts "You hit cancel"
            end
          end
        end

        acs.append(UIButton, :alert_controller_okcancel).on(:tap) do
         rmq.app.alert(message: "Log Out?", actions: :ok_cancel) do |title|
            case title
            when :ok
              puts "Fictitiously logging you out"
            when :cancel
              puts "You hit cancel"
            end
          end
        end

        acs.append(UIButton, :alert_controller_deletecancel).on(:tap) do
         rmq.app.alert(title: "DESTROY!!!", message: "Would you like to remove some important data?", actions: :delete_cancel) do |title|
            case title
            when :delete
              puts "Destroying that data!"
            when :cancel
              puts "keep all the things!"
            end
          end
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
