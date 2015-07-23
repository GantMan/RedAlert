describe "RubyMotionQuery" do
  describe "AlertViewProvider" do

    before do
      @p      = RubyMotionQuery::AlertViewProvider.new
      @fieldset = {alert_view_style: UIAlertViewStylePlainTextInput, fields: [RubyMotionQuery::AlertField.new(:text)]}
      @ok     = RubyMotionQuery::AlertAction.new(title: "OK", tag: :ok, style: :default)
      @cancel = RubyMotionQuery::AlertAction.new(title: "Cancel", tag: :cancel, style: :cancel)
      @boom   = RubyMotionQuery::AlertAction.new(title: "Boom!", tag: :boom, style: :destructive)
    end

    shared "an alert view with ok button" do

      it "should have the right title" do
        @p.alert_view.title.should == "title"
      end

      it "should have the right message" do
        @p.alert_view.message.should == "message"
      end

      it "should create a UIAlertView" do
        @p.alert_view.class.should == UIAlertView
      end

      it "should have 1 button" do
        @p.alert_view.numberOfButtons.should == 1
      end

      it "should have 0 cancel buttons" do
        @p.alert_view.cancelButtonIndex.should < 0
      end

      it "should have the right button title" do
        @p.alert_view.buttonTitleAtIndex(0).should == @ok.title
      end

    end

    shared "an alert view with a cancel button" do

      it "should have 1 button" do
        @p.alert_view.numberOfButtons.should == 1
      end

      it "should have 1 cancel button" do
        @p.alert_view.cancelButtonIndex.should == 0
      end

      it "should have the right button title" do
        @p.alert_view.buttonTitleAtIndex(0).should == @cancel.title
      end

    end

    shared "an alert view with a destructive button" do

      it "should have 1 button" do
        @p.alert_view.numberOfButtons.should == 1
      end

      it "should have 0 cancel buttons" do
        @p.alert_view.cancelButtonIndex.should == -1
      end

      it "should have the right button title" do
        @p.alert_view.buttonTitleAtIndex(0).should == @boom.title
      end

    end

    shared "an alert view with one field" do

      it "has the expected alertViewStyle value" do
        @p.alert_view.alertViewStyle.should == UIAlertViewStylePlainTextInput
      end

      it 'has a text field with an empty placeholder' do
        @p.alert_view.textFieldAtIndex(0).placeholder.should == nil
      end

    end

    it "should prevent nil actions" do
      Proc.new { @p.build(nil) }.should.raise(ArgumentError)
    end

    it "should prevent empty actions" do
      Proc.new { @p.build([]) }.should.raise(ArgumentError)
    end

    context 'without fields' do

      describe "alert view with ok button" do

        before do
          @p.build [@ok], nil, title: "title", message: "message"
        end

        behaves_like "an alert view with ok button"

      end

      describe "alert view with a cancel button" do

        before do
          @p.build [@cancel], @fieldset, title: "title"
        end

        behaves_like "an alert view with a cancel button"

      end

      describe "an alert view with a destructive button" do

        before do
          @p.build [@boom], @fieldset, title: "title"
        end

        behaves_like "an alert view with a destructive button"

      end

    end

    context 'with fields' do

      describe "alert view with ok button" do

        before do
          @p.build [@ok], @fieldset, title: "title", message: "message"
        end

        behaves_like "an alert view with ok button"
        behaves_like "an alert view with one field"

      end

      describe "alert view with a cancel button" do

        before do
          @p.build [@cancel], @fieldset, title: "title"
        end

        behaves_like "an alert view with a cancel button"
        behaves_like "an alert view with one field"

      end

      describe "an alert view with a destructive button" do

        before do
          @p.build [@boom], @fieldset, title: "title"
        end

        behaves_like "an alert view with a destructive button"
        behaves_like "an alert view with one field"

      end
    end

  end
end
