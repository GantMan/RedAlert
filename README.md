[![image](http://ir_wp.s3.amazonaws.com/wp-content/uploads/sites/19/2014/09/rmq_plugin.png)](http://rubymotionquery.com)

# redpotion_alert

**Did you know that UIAlertView and UIActionSheet (as well as their respective delegate protocols) are deprecated in iOS 8?**

`UIAlertController` is used in this gem.   Gracefully falls back to `UIAlertView` for versions older than iOS8

## Installation

**Requires RMQ 0.8.0 or later, and iOS 7 or later**#

TODO: Write install instructions here

## Usage

TODO: Write usage instructions here
```ruby

  rmq.alert("Are you alive?") do
    p "He is alive!"
  end

  rmq.alert(title: "foo", message: "Are you alive?") do
    p "He is alive!"
  end

  rmq.alert(message: "Would you like a sandwich?", actions: :yes_no_cancel, style: :sheet) { |action_type|
    case action_type
    when :yes
      p "yes"
    when :no
      p "no"
    end
  }


  rmq.alert(title: "foo", message: "Would you like a sandwich?", actions: []
  }


  rmq.alert(title: "More Actions",
            message: "UIViewController 2",
            actions: [
              {text: "OK", style: :default, handler: ->{}}
              {text: "OK", style: :default, handler: ->{}}
            ])
```


### Example using stylesheet:

TODO: stylesheet example here

### Example without stylesheet:

TODO: no stylesheet example here

### Methods

TODO: list methods available to user here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
