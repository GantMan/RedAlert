return unless rmq.device.ios_at_least?(8)

describe 'RedAlert' do

  TEST_DELAY = 0.1

  describe "UIAlertController Hosted" do

    before do
      wait TEST_DELAY do
        UIView.setAnimationsEnabled false
        @vc = rmq.view_controller
        @provider = rmq.app.alert(message: "hello", show_now: false, animated: false)
      end
    end

    after do
    end

    it "uses the proper provider class" do
      @provider.class.should == RubyMotionQuery::AlertControllerProvider
    end

    it "has access to the UIAlertController" do
      @provider.alert_controller.class.should == UIAlertController
    end

    it "has the proper visibility timing" do
      rmq.view_controller.should == @vc
      @provider.show
      wait TEST_DELAY do
        rmq.view_controller.should.not == @vc
        @vc.dismissViewControllerAnimated(false, completion: nil)
        wait TEST_DELAY do
          rmq.view_controller.should == @vc
        end
      end
    end

    it "has the correct title" do
      @provider.alert_controller.title.should == nil
    end

    it "has the correct message" do
      @provider.alert_controller.message.should == "hello"
    end

  end

  describe "UIActionSheet Hosted" do

    before do
      wait TEST_DELAY do
        UIView.setAnimationsEnabled false
        @vc = rmq.view_controller
        @provider = rmq.app.alert(message: "hello", show_now: false, animated: false, style: :sheet, api: :deprecated)
      end
    end

    it "uses the proper provider" do
      @provider.class.should == RubyMotionQuery::ActionSheetProvider
    end

    it "has access to the UIActionSheet" do
      @provider.action_sheet.class.should == UIActionSheet
    end

    it "has a valid blank title" do
      rmq.app.alert(show_now: false, animated: false, style: :sheet, api: :deprecated).action_sheet.title.should == "Alert!"
    end

    it "has a valid title when given" do
      rmq.app.alert(title: "hi", show_now: false, animated: false, style: :sheet, api: :deprecated).action_sheet.title.should == "hi"
    end

    it "should transfer message over to title when there is no title" do
      rmq.app.alert(message: "hi", show_now: false, animated: false, style: :sheet, api: :deprecated).action_sheet.title.should == "hi"
    end

    it "should never overwrite title with message" do
      rmq.app.alert(title: "1", message: "2", show_now: false, animated: false, style: :sheet, api: :deprecated).action_sheet.title.should == "1"
    end

    it "should be visible at the right time" do
      # TODO: why doesn't the action_sheet.visible work?
      @provider.action_sheet.isVisible.should == false
      @provider.show
      wait TEST_DELAY do
        @provider.action_sheet.isVisible.should == true
        @provider.action_sheet.dismissWithClickedButtonIndex(0, animated:false)
        wait TEST_DELAY do
          @provider.action_sheet.isVisible.should == false
        end
      end
    end

  end

  describe "UIAlertView Hosted" do

    shared "a properly configured UIAlertView provider" do

      it "uses the proper provider" do
        @provider.class.should == RubyMotionQuery::AlertViewProvider
      end

      it "should have access to the UIAlertView" do
        @provider.alert_view.class.should == UIAlertView
      end

      it "should should be visible at the right time" do
        # TODO: why doesn't the alert_view.visible work?
        @provider.alert_view.isVisible.should == false
        @provider.show
        wait TEST_DELAY do
          @provider.alert_view.isVisible.should == true
          @provider.alert_view.dismissWithClickedButtonIndex(0, animated:false)
          wait TEST_DELAY do
            @provider.alert_view.isVisible.should == false
          end
        end
      end

      it "has the correct title" do
        @provider.alert_view.title.should == "hi!"
      end

      it "has the correct message" do
        @provider.alert_view.message.should == "hello"
      end

    end

    context "using an alert style" do

      before do
        wait TEST_DELAY do
          UIView.setAnimationsEnabled false
          @vc = rmq.view_controller
          @provider = rmq.app.alert(title: "hi!", message: "hello", show_now: false, animated: false, style: :alert, api: :deprecated)
        end
      end

      behaves_like "a properly configured UIAlertView provider"

    end

    context "with a field style" do

      before do
        wait TEST_DELAY do
          UIView.setAnimationsEnabled false
          @vc = rmq.view_controller
          @provider = rmq.app.alert(title: "hi!", message: "hello", show_now: false, animated: false, style: :change_password, api: :deprecated)
        end
      end

      behaves_like "a properly configured UIAlertView provider"

      it "has the expected alertViewStyle value" do
        @provider.alert_view.alertViewStyle.should == UIAlertViewStyleLoginAndPasswordInput
      end

      it 'has the correct placeholder text for the change password template fields' do
        @provider.alert_view.textFieldAtIndex(0).placeholder.should == "Current Password"
        @provider.alert_view.textFieldAtIndex(1).placeholder.should == "New Password"
      end

    end

  end

end
