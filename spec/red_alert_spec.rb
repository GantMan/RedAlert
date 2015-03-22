describe 'RedAlert' do

  before do
    UIView.setAnimationsEnabled false
    @vc = rmq.view_controller
  end

  after do
    @vc.dismissViewControllerAnimated(false, completion: nil)
  end

  it 'should return the created alert controller' do
    basic_alert_controller = @vc.rmq.alert(message: 'simple message', show_now: false)
    basic_alert_controller.is_a?(UIAlertController).should.be.true
  end

  it 'has a collection view in the created alert' do
    basic_alert_controller = @vc.rmq.alert(message: 'simple message', show_now: false)
    basic_alert_controller.rmq(UICollectionView).size.should == 1
  end

  describe "features of a default alert" do

    before do
      @basic_alert_controller = @vc.rmq.alert(message: 'my message')
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

  describe "features of the :yes_no template" do

    before do
      @yes_no_controller = rmq.alert(message: 'my message', actions: :yes_no, show_now: false)
      wait 1 do
        rmq.view_controller.presentViewController(@yes_no_controller, animated: false, completion: nil)
      end
    end

    it 'has the correct values for a :yes_no template' do
      # Default title
      @yes_no_controller .rmq(UILabel)[0].get.text.should == "Alert!"
      # Assigned message
      @yes_no_controller .rmq(UILabel)[1].get.text.should == 'my message'

      # Check for the buttons
      wait 1 do
        @yes_no_cancel_controller.rmq(text: "Yes").size.should == 1
        @yes_no_cancel_controller.rmq(text: "No").size.should == 1
      end
    end

  end

  describe "features of the :yes_no_cancel template" do

    before do
      @yes_no_cancel_controller = rmq.alert(message: 'yes no cancel', actions: :yes_no_cancel, show_now: false)
      wait 1 do
        rmq.view_controller.presentViewController(@yes_no_cancel_controller, animated: false, completion: nil)
      end
    end

    it 'has the correct values for a :yes_no_cancel template' do
      # Default title
      @yes_no_cancel_controller.rmq(UILabel)[0].get.text.should == "Alert!"
      # Assigned message
      @yes_no_cancel_controller.rmq(UILabel)[1].get.text.should == 'yes no cancel'

      # Check for the buttons
      wait 1 do
        @yes_no_cancel_controller.rmq(text: "Yes").size.should == 1
        @yes_no_cancel_controller.rmq(text: "No").size.should == 1
        @yes_no_cancel_controller.rmq(text: "Cancel").size.should == 1
      end
    end

  end
end