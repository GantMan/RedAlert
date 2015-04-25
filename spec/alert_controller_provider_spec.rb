return unless rmq.device.ios_at_least?(8)

describe "RubyMotionQuery" do
  describe "AlertControllerProvider" do

    before do
      @p      = RubyMotionQuery::AlertControllerProvider.new
      @ok     = RubyMotionQuery::AlertAction.new(title: "OK", tag: :ok, style: :default)
      @cancel = RubyMotionQuery::AlertAction.new(title: "Cancel", tag: :cancel, style: :cancel)
      @boom   = RubyMotionQuery::AlertAction.new(title: "Boom!", tag: :boom, style: :destructive)
    end

    it "should prevent nil actions" do
      Proc.new { @p.build(nil) }.should.raise(ArgumentError)
    end

    it "should prevent empty actions" do
      Proc.new { @p.build([]) }.should.raise(ArgumentError)
    end

    describe "alert controller with ok button" do

      before do
        @p.build [@ok], title: "title", style: :alert
      end

      it "should have the right title" do
        @p.alert_controller.title.should == "title"
      end

      it "should create a AlertController" do
        @p.alert_controller.class.should == UIAlertController
      end

      it "should have 1 button" do
        @p.alert_controller.actions.length.should == 1
      end

      it "should have 0 cancel buttons" do
        @p.alert_controller.actions.find_all { |a| a.style == UIAlertActionStyleCancel}.length.should == 0
      end

      it "should have 0 destructive buttons" do
        @p.alert_controller.actions.find_all { |a| a.style == UIAlertActionStyleDestructive}.length.should == 0
      end

      it "should have the right button title" do
        @p.alert_controller.actions.first.title.should == @ok.title
      end

    end

    describe "alert controller with a cancel button" do

      before do
        @p.build [@cancel], title: "title", style: :sheet
      end

      it "should have 1 button" do
        @p.alert_controller.actions.length.should == 1
      end

      it "should have 1 cancel button" do
        @p.alert_controller.actions.find_all { |a| a.style == UIAlertActionStyleCancel}.length.should == 1
      end

      it "should have 0 destructive buttons" do
        @p.alert_controller.actions.find_all { |a| a.style == UIAlertActionStyleDestructive}.length.should == 0
      end

      it "should have the right button title" do
        @p.alert_controller.actions.first.title.should == @cancel.title
      end

    end

    describe "alert controller with a destructive button" do

      before do
        @p.build [@boom], title: "title", style: :alert
      end

      it "should have 1 button" do
        @p.alert_controller.actions.length.should == 1
      end

      it "should have 0 cancel buttons" do
        @p.alert_controller.actions.find_all { |a| a.style == UIAlertActionStyleCancel}.length.should == 0
      end

      it "should have 1 destructive buttons" do
        @p.alert_controller.actions.find_all { |a| a.style == UIAlertActionStyleDestructive}.length.should == 1
      end

      it "should have the right button title" do
        @p.alert_controller.actions.first.title.should == @boom.title
      end

    end


  end
end
