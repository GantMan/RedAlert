<img src="./_art/logo.png" alt="RedAlert Logo" width="100" />
[![image](http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/19/2014/09/rmq_plugin.png)](http://rubymotionquery.com)

# RedAlert
Easy Alerts and ActionSheets with RMQ

### Did you know that UIAlertView and UIActionSheet (as well as their respective delegate protocols) are deprecated in iOS 8?

Apple requests you start using the new `UIAlertController`.  This gem is built on `UIAlertController` and RMQ, along with support for antiquated `UIAlertView`s for the gnostalgic.

With an emphasis on ease of use, this gem allows you to quickly implement Alerts and Actionsheets in your RMQ RubyMotion applications.

## Screenshot

<img src="./_art/screen.png" alt="Screen Shot" width="500" />

## Installation

**Requires RMQ 1.2.0 or later, and iOS 8 or later**

Add the RedAlert gem to your Gemfile.
```ruby
  gem 'RedAlert'
```

## Usage

```ruby

  # Simply do an alert
  rmq.alert("Minimal Alert")

  # Alert with callback
  rmq.alert("Alert with Block") {
    puts "Alert with Block worked!"
  }
  
  # Modify some snazzy options
  alert_controller = rmq.alert(title: "New Title", message: "Great message", animated: false)

  # Switch it to look like an ActionSheet by setting the style
  rmq.alert(title: "Hey there!", message: "My style is :sheet", style: :sheet) do |action_type|
    puts "you clicked #{action_type}"
  end  
  
  # Utilize common templates
  rmq.alert(message: "Would you like a sandwich?", actions: :yes_no_cancel, style: :sheet) do |title|
    case title
    when :yes
      puts "Here's your Sandwich!"
    when :no
      puts "FINE!"
    end
  end  
```

You can even use the `make_button` helper to create custom UIAction buttons to add:
```ruby
  # Use custom UIAction buttons and add them
  taco = rmq.make_button("Taco") {
            puts "Taco pressed"
          }
  nacho = rmq.make_button(title: "Nacho", style: :destructive)  {
            puts "Nacho pressed"
          }          
  button_list = [taco, nacho]        
  rmq.alert(title: "Actions!", message: "Actions created with `make_button` helper.", actions: button_list)
```

## Available Templates

Templates are provided [HERE](https://github.com/GantMan/RedAlert/blob/master/lib/project/button_templates.rb)
* `:yes_no` = Simple yes and no buttons.
* `:yes_no_cancel` = Yes/no buttons with a separated cancel button.
* `:ok_cancel` = OK button with a separated cancel button.
* `:delete_cancel` = Delete button (red) with a separated cancel button.

_More to come:_ be sure to submit a pull-request with your button template needs.

## More info

Feel free to read up on UIAlertController to see what all is wrapped up in this gem.
* [Hayageek](http://hayageek.com/uialertcontroller-example-ios/)
* [NSHipster](http://nshipster.com/uialertcontroller/)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
