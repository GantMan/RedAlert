<img src="./_art/logo.png" alt="RedAlert Logo" width="100" />
[![image](http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/19/2014/09/rmq_plugin.png)](http://rubymotionquery.com)

# RedAlert
[![Gem Version](https://badge.fury.io/rb/RedAlert.svg)](http://badge.fury.io/rb/RedAlert) [![Build Status](https://travis-ci.org/GantMan/RedAlert.svg)](https://travis-ci.org/GantMan/RedAlert) _Alerts and ActionSheets with ease_

### Did you know that UIAlertView and UIActionSheet (as well as their respective delegate protocols) are deprecated in iOS 8?

Apple requests you start using the new `UIAlertController`.  This gem is built on `UIAlertController` and RMQ, along with seemless support for antiquated `UIAlertView`s & `UIActionSheet`s for the gnostalgic.

With an emphasis on ease of use, this gem allows you to quickly implement Alerts and Actionsheets in your RMQ RubyMotion applications.

When run on iOS 8, RedAlert uses `UIAlertController` to present alerts and sheets.

When run on iOS 7, RedAlert uses `UIAlertView` present alerts and `UIActionSheet` to present sheets.

*:dart: RedAlert Means you don't have to worry about a thing!*

## In Action

<img src="./_art/demo.gif" alt="Demo" width="369" height="677" />

## Installation

**Requires RMQ 1.2.0 or later, and iOS 7 or later**

Add the **RedAlert** gem to your Gemfile.
```ruby
  gem 'RedAlert'
```

## Usage
**Note:  If you're using [RedPotion](https://github.com/infinitered/redpotion) then `rmq.app` can be accessed by simply typing `app`, so `rmq.app.alert` would be simply `app.alert`.  The following examples are verbose and assume only [RMQ](https://github.com/infinitered/rmq).**

```ruby

  # Simply do an alert
  rmq.app.alert("Minimal Alert")

  # Alert with callback
  rmq.app.alert("Alert with Block") {
    puts "Alert with Block worked!"
  }

  # Modify some snazzy options
  rmq.app.alert(title: "New Title", message: "Great message", animated: false)

  # Switch it to look like an ActionSheet by setting the style
  rmq.app.alert(title: "Hey there!", message: "My style is :sheet", style: :sheet) do |action_type|
    puts "You clicked #{action_type}"
  end

  # Add input fields by setting the style
  rmq.app.alert(title: "Text Field", message: "My style is :login", style: :login) do |action_type, fields|
    puts "you entered '#{fields[:login].text}' as the login and '#{fields[:password].text}' as the password"
  end

  # Add input fields with settings for placeholder text, whether the field is secure, and the keyboard type by setting the style to :custom
  rmq.app.alert(title: "Text Field", message: "My style is :custom", style: :custom, fields:
               {phone: {placeholder: 'Phone', keyboard_type: :phone_pad},
                email: {placeholder: 'Email', secure: false, keyboard_type: :email_address}}) do |action_type, fields|
    puts "you entered '#{fields[:phone].text}' and '#{fields[:email].text}'"
  end

  # Utilize common templates
  rmq.app.alert(message: "Would you like a sandwich?", actions: :yes_no_cancel, style: :sheet) do |action_type|
    case action_type
    when :yes
      puts "Here's your Sandwich!"
    when :no
      puts "FINE!"
    end
  end
```

You can pass in symbols or strings and we'll build the buttons for you:

```ruby
rmq.app.alert title: "Hey!", actions: [ "Go ahead", :cancel, :delete ] do |button_tag|
  case button_tag
  when :cancel then puts "Canceled!"
  when :delete then puts "Deleted!"
  when "Go ahead" then puts "Going ahead!"
  end
end
```


You can even use the `make_button` helper to create custom buttons to add:
```ruby
  # Use custom UIAction buttons and add them
  taco = rmq.app.make_button("Taco") {
            puts "Taco pressed"
          }
  nacho = rmq.app.make_button(title: "Nacho", style: :destructive)  {
            puts "Nacho pressed"
          }
  button_list = [taco, nacho]
  rmq.app.alert(title: "Actions!", message: "Actions created with `make_button` helper.", actions: button_list)
```


If you want to present your alert in :sheet style and you are on iPad, you have to provide the `:source` for the popover (either a UIView or a UIBarButtonItem)
```ruby
rmq.append(UIButton, :my_button).on(:tap) do |sender|
  rmq.app.alert(title: "Actions!", message: "Alert from a Popover.", actions: [:ok, :cancel], style:sheet, source: sender)
end
```
You can also provide a `:modal` option if you want the popover to be modal. This option is only available for iOS 8+.

## Available Templates

Button templates are provided [HERE](https://github.com/GantMan/RedAlert/blob/master/lib/project/button_templates.rb)
* `:yes_no` = Simple yes and no buttons.
* `:yes_no_cancel` = Yes/no buttons with a separated cancel button.
* `:ok_cancel` = OK button with a separated cancel button.
* `:delete_cancel` = Delete button (red) with a separated cancel button.

Field templates are provided [HERE](https://github.com/GantMan/RedAlert/blob/master/lib/project/field_templates.rb)
* `:input` = One plaintext input field.
* `:secure` = One secure input field.
* `:login` = Two fields, one plaintext with placeholder text 'Login' and the other secure with placeholder text 'Password'.
* `:change_password` = Two fields, one secure with placeholder text 'Current Password' and the other secure with placeholder text 'New Password'.

:heartbeat: _More to come:_ be sure to submit a pull-request with your button template needs.


## iOS 7 Support

If you still need iOS 7, RedAlert has your back.

Instead of using iOS 8's UIAlertController, RedAlert will use UIActionSheet to display your sheets and
UIAlertView to display your views.

**With little-to-no changes to your code.**

Because capabilities of iOS 7 & 8 alert-components are different, just a few edge cases that might sting you (but nothing critical):

* `UIAlertView` doesn't have the concept of :destructive buttons.  These will fall back to :default.
* `UIAlertView` cares about the order of your `:cancel` actions, so `[:ok, :cancel]` is shown different than `[:cancel, :ok]`.
* `UIActionSheet` also cares about the order.  It's possible to put a `:cancel` first, which looks slightly awkward when shown.  Try to put `:cancel` last.
* `UIAlertView`'s `alertViewStyles` are not available through RedAlert as they aren't compatible with iOS 8.  You'll have to call that directly.
* `UIAlertView only supports up to 2 input fields.`

## Credits and Info

**i18n support by [Mark Rickert](https://github.com/GantMan/RedAlert/pull/2)**

**iOS 7 support by [Steve Kellock](https://github.com/GantMan/RedAlert/pull/3)**

**Automatic button building by [Jamon Holmgren](https://github.com/GantMan/RedAlert/pull/7)**

**Ability to add textfields to alerts (Like Username/Password) by [Derek Greenberg](https://github.com/GantMan/RedAlert/pull/10) and notable work by [Jon Silverman](https://github.com/GantMan/RedAlert/pull/9)**

Feel free to read up on UIAlertController to see what all is wrapped up in this gem.
* [Hayageek](http://hayageek.com/uialertcontroller-example-ios/)
* [NSHipster](http://nshipster.com/uialertcontroller/)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Realize no one ever reads this section
6. Create new Pull Request
