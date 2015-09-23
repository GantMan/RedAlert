describe "RedAlert.map_action_buttons" do

  it "builds cancel button" do
    test_array = [ :cancel ]
    callback = ->(){}
    subject = RubyMotionQuery::App.map_action_buttons(test_array, &callback )
    subject.should.be.all {|s| s.is_a?(RubyMotionQuery::AlertAction) }
    subject[0].title.should == "Cancel"
    subject[0].tag.should == :cancel
    subject[0].style.should == :cancel
    subject[0].handler.should == callback
  end

  it "builds delete button" do
    test_array = [ :delete ]
    callback = ->(){}
    subject = RubyMotionQuery::App.map_action_buttons(test_array, &callback )
    subject.should.be.all {|s| s.is_a?(RubyMotionQuery::AlertAction) }
    subject[0].title.should == "Delete"
    subject[0].tag.should == :delete
    subject[0].style.should == :destructive
    subject[0].handler.should == callback
  end

  it "builds ok button" do
    test_array = [ :ok ]
    callback = ->(){}
    subject = RubyMotionQuery::App.map_action_buttons(test_array, &callback )
    subject.should.be.all {|s| s.is_a?(RubyMotionQuery::AlertAction) }
    subject[0].title.should == "OK"
    subject[0].tag.should == :ok
    subject[0].style.should == :default
    subject[0].handler.should == callback
  end

  # it "builds yes button" do
  #   test_array = [ :yes ]
  #   callback = ->(){}
  #   subject = RubyMotionQuery::App.map_action_buttons(test_array, &callback )
  #   subject.should.be.all {|s| s.is_a?(RubyMotionQuery::AlertAction) }
  #   subject[0].title.should == "Yes"
  #   subject[0].tag.should == :yes
  #   subject[0].style.should == :default
  #   subject[0].handler.should == callback
  # end

  it "builds no button" do
    test_array = [ :no ]
    callback = ->(){}
    subject = RubyMotionQuery::App.map_action_buttons(test_array, &callback )
    subject.should.be.all {|s| s.is_a?(RubyMotionQuery::AlertAction) }
    subject[0].title.should == "No"
    subject[0].tag.should == :no
    subject[0].style.should == :default
    subject[0].handler.should == callback
  end


  it "builds custom button" do
    test_array = [ "Custom" ]
    callback = ->(){}
    subject = RubyMotionQuery::App.map_action_buttons(test_array, &callback )
    subject.should.be.all {|s| s.is_a?(RubyMotionQuery::AlertAction) }
    subject[0].title.should == "Custom"
    subject[0].tag.should == "Custom"
    subject[0].style.should == :default
    subject[0].handler.should == callback
  end

  # it "builds lots of buttons" do
  #   callback = ->(){}
  #   custom_button = RubyMotionQuery::AlertAction.new(title: "Custom", tag: "Custom", &callback)
  #   test_array = [ "A", "B", "C", custom_button, :yes, :no, :ok, :delete, :cancel ]
  #   subject = RubyMotionQuery::App.map_action_buttons(test_array, &callback )
  #   subject.should.be.all {|s| s.is_a?(RubyMotionQuery::AlertAction) }
  #   subject[0].title.should == "A"
  #   subject[1].title.should == "B"
  #   subject[2].title.should == "C"
  #   subject[3].should.be == custom_button
  #   subject[4].title.should == "Yes"
  #   subject[5].title.should == "No"
  #   subject[6].title.should == "OK"
  #   subject[7].title.should == "Delete"
  #   subject[8].title.should == "Cancel"
  # end


end
