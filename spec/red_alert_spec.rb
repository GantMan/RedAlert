describe 'RedAlert' do

  TEST_DELAY = 0.3
  before do
    UIView.setAnimationsEnabled false
    @vc = rmq.view_controller
  end

  after do
    @vc.dismissViewControllerAnimated(false, completion: nil)
  end

  it 'should return the created alert controller' do
    basic_alert_controller = @vc.rmq.app.alert(message: 'simple message', show_now: false)
    basic_alert_controller.is_a?(UIAlertController).should.be.true
  end

  it 'has a collection view in the created alert' do
    basic_alert_controller = @vc.rmq.app.alert(message: 'simple message', show_now: false)
    basic_alert_controller.rmq(UICollectionView).size.should == 1
  end

  describe "default alert" do

    before do
      @basic_alert_controller = @vc.rmq.app.alert(message: 'my message')
    end

    it 'has the correct values in the right places' do
      # Default title
      title = @basic_alert_controller.rmq(UILabel)[0].first.get
      title.text.should == "Alert!"
      # Assigned message
      message = @basic_alert_controller.rmq(UILabel)[1].get
      message.text.should == 'my message'
    end

  end

  describe ":yes_no template" do
    before do
      @yes_no_controller = rmq.app.alert(message: 'yes_no', actions: :yes_no, show_now: false)
      wait TEST_DELAY do
        rmq.view_controller.presentViewController(@yes_no_controller, animated: false, completion: nil)
      end
    end

    it 'has the correct values for a :yes_no template' do
      # Default title
      @yes_no_controller .rmq(UILabel)[0].get.text.should == "Alert!"
      # Assigned message
      @yes_no_controller .rmq(UILabel)[1].get.text.should == 'yes_no'

      # Check for the buttons
      wait TEST_DELAY do
        @yes_no_cancel_controller.rmq(text: "Yes").size.should == 1
        @yes_no_cancel_controller.rmq(text: "No").size.should == 1
      end
    end
  end

  describe ":yes_no_cancel template" do
    before do
      @yes_no_cancel_controller = rmq.app.alert(message: 'yes_no_cancel', actions: :yes_no_cancel, show_now: false)
      wait TEST_DELAY do
        rmq.view_controller.presentViewController(@yes_no_cancel_controller, animated: false, completion: nil)
      end
    end

    it 'has the correct values for a :yes_no_cancel template' do
      # Default title
      @yes_no_cancel_controller.rmq(UILabel)[0].get.text.should == "Alert!"
      # Assigned message
      @yes_no_cancel_controller.rmq(UILabel)[1].get.text.should == 'yes_no_cancel'

      # Check for the buttons
      wait TEST_DELAY do
        @yes_no_cancel_controller.rmq(text: "Yes").size.should == 1
        @yes_no_cancel_controller.rmq(text: "No").size.should == 1
        @yes_no_cancel_controller.rmq(text: "Cancel").size.should == 1
      end
    end
  end

  describe ":ok_cancel template" do
    before do
      @ok_cancel = rmq.app.alert(title: "ok_cancel title", message: 'ok_cancel', actions: :ok_cancel, show_now: false)
      wait TEST_DELAY do
        rmq.view_controller.presentViewController(@ok_cancel, animated: false, completion: nil)
      end
    end

    it 'has the correct values for a :ok_cancel template' do
      # Default title
      @ok_cancel.rmq(UILabel)[0].get.text.should == "ok_cancel title"
      # Assigned message
      @ok_cancel.rmq(UILabel)[1].get.text.should == 'ok_cancel'

      # Check for the buttons
      wait TEST_DELAY do
        @ok_cancel.rmq(text: "OK").size.should == 1
        @ok_cancel.rmq(text: "Cancel").size.should == 1
      end
    end
  end

  describe ":delete_cancel template" do
    before do
      @delete_cancel = rmq.app.alert(title: "delete_cancel title", message: 'delete_cancel', actions: :delete_cancel, show_now: false)
      wait TEST_DELAY do
        rmq.view_controller.presentViewController(@delete_cancel, animated: false, completion: nil)
      end
    end

    it 'has the correct values for a :delete_cancel template' do
      # Default title
      @delete_cancel.rmq(UILabel)[0].get.text.should == "delete_cancel title"
      # Assigned message
      @delete_cancel.rmq(UILabel)[1].get.text.should == 'delete_cancel'

      # Check for the buttons
      wait TEST_DELAY do
        @delete_cancel.rmq(text: "Delete").size.should == 1
        @delete_cancel.rmq(text: "Cancel").size.should == 1
      end
    end
  end

  describe "i18n capability" do
    class French
      class << self
        attr_writer :enabled

        def enabled?
          @enabled || false
        end
      end
    end


    class Kernel
      def NSLocalizedString(key, comment)
        if French.enabled?
          path =  NSBundle.mainBundle.pathForResource('fr', ofType:"lproj" )
          bundle = NSBundle.bundleWithPath(path)
          bundle.localizedStringForKey(key, value:comment, table:nil)
        else
          key
        end
      end
    end

    before do
      French.enabled = true

      @yes_no_cancel_controller = rmq.app.alert(message: 'yes_no_cancel', actions: :yes_no_cancel, show_now: false)
      wait TEST_DELAY do
        rmq.view_controller.presentViewController(@yes_no_cancel_controller, animated: false, completion: nil)
      end
    end

    after do
      French.enabled = false
    end

    it 'has the correct values for a :yes_no_cancel template' do
      # Default title
      @yes_no_cancel_controller.rmq(UILabel)[0].get.text.should == "Alerte!"
      # Assigned message
      @yes_no_cancel_controller.rmq(UILabel)[1].get.text.should == 'yes_no_cancel'

      # Check for the buttons
      wait TEST_DELAY do
        @yes_no_cancel_controller.rmq(text: "Oui").size.should == 1
        @yes_no_cancel_controller.rmq(text: "Pas").size.should == 1
        @yes_no_cancel_controller.rmq(text: "Annuler").size.should == 1
      end
    end
  end

end
