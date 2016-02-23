module RubyMotionQuery
  class App

    # When adding a new template do the following:
    # 1 - Add it here
    # 2 - Add the test
    # 3 - Add symbol to the README.md list

    def self.add_template_fieldset(template, opts={})

      login             = NSLocalizedString("Login", nil)
      password          = NSLocalizedString("Password", nil)
      current_password  = NSLocalizedString("Current Password", nil)
      new_password      = NSLocalizedString("New Password", nil)

      fieldset = {alert_view_style: UIAlertViewStyleDefault, fields: [] }
      case template
        when :input
          fieldset[:alert_view_style] = UIAlertViewStylePlainTextInput
          fieldset[:fields] =
          [
            rmq.app.make_field(:text, keyboard_type: :default, secure_text_entry: false, placeholder: opts.fetch(:placeholder,''), text: opts.fetch(:text,''))
          ]
        when :secure
          fieldset[:alert_view_style] = UIAlertViewStyleSecureTextInput
          fieldset[:fields] =
            [
              rmq.app.make_field(:text, keyboard_type: :default, secure_text_entry: true, placeholder: opts.fetch(:placeholder,''))
            ]
        when :login
          fieldset[:alert_view_style] = UIAlertViewStyleLoginAndPasswordInput
          fieldset[:fields] =
            [
              rmq.app.make_field(:login, keyboard_type: :email_address, secure_text_entry: false, placeholder: login),
              rmq.app.make_field(:password, keyboard_type: :default, secure_text_entry: true, placeholder: password)
            ]
        when :change_password
          fieldset[:alert_view_style] = UIAlertViewStyleLoginAndPasswordInput
          fieldset[:fields] =
            [
              rmq.app.make_field(:current_password, keyboard_type: :default, secure_text_entry: true, placeholder: current_password),
              rmq.app.make_field(:new_password, keyboard_type: :default, secure_text_entry: true, placeholder: new_password)
            ]
      end
      fieldset
    end
  end
end
