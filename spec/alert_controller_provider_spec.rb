return unless rmq.device.ios_at_least?(8)

describe "RubyMotionQuery" do
  describe "AlertControllerProvider" do

    before do
      @p      = RubyMotionQuery::AlertControllerProvider.new
      @fieldset = {alert_view_style: UIAlertViewStylePlainTextInput, fields: [RubyMotionQuery::AlertField.new(:text)]}
      @ok     = RubyMotionQuery::AlertAction.new(title: "OK", tag: :ok, style: :default)
      @cancel = RubyMotionQuery::AlertAction.new(title: "Cancel", tag: :cancel, style: :cancel)
      @boom   = RubyMotionQuery::AlertAction.new(title: "Boom!", tag: :boom, style: :destructive)
      @field = RubyMotionQuery::AlertField.new(:text)
    end

    shared "an alert controller with ok button" do

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

    shared "an alert controller with a cancel button" do

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

    shared "an alert controller with a destructive button" do

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

    shared "an alert view with one field" do

      it "has one text field" do
        @p.alert_controller.textFields.count.should == 1
      end

      it 'has a text field with an empty placeholder' do
        @p.alert_controller.textFields[0].placeholder.should == nil
      end

      it 'has the expected preferred style' do
        @p.alert_controller.preferredStyle.should == UIAlertControllerStyleAlert
      end

    end

    it "should prevent nil actions" do
      Proc.new { @p.build(nil) }.should.raise(ArgumentError)
    end

    it "should prevent empty actions" do
      Proc.new { @p.build([]) }.should.raise(ArgumentError)
    end

    context 'without fields' do

      describe "alert controller with ok button" do

        before do
          @p.build [@ok], nil, title: "title", style: :alert
        end

        behaves_like "an alert controller with ok button"

      end

      describe "alert controller with a cancel button" do

        before do
          @p.build [@cancel], nil, title: "title", style: :sheet
        end

        behaves_like "an alert controller with a cancel button"

      end

      describe "alert controller with a destructive button" do

        before do
          @p.build [@boom], nil, title: "title", style: :alert
        end

        behaves_like "an alert controller with a destructive button"

      end

    end

    context 'with fields' do

      describe "alert controller with ok button" do

        before do
          @p.build [@ok], @fieldset, title: "title", style: :alert
        end

        behaves_like "an alert controller with ok button"
        behaves_like "an alert view with one field"

      end

      describe "alert controller with a cancel button" do

        before do
          @p.build [@cancel], @fieldset, title: "title", style: :alert
        end

        behaves_like "an alert controller with a cancel button"
        behaves_like "an alert view with one field"

      end

      describe "alert controller with a destructive button" do

        before do
          @p.build [@boom], @fieldset, title: "title", style: :alert
        end

        behaves_like "an alert controller with a destructive button"
        behaves_like "an alert view with one field"

      end

    end


  end
end
