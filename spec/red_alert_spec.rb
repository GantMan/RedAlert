describe 'RedAlert' do

  it 'should return the created alert controller' do
    basic_alert_controller = rmq.alert('simple message')
    basic_alert_controller.is_a?(UIAlertController).should.be.true
  end

  it 'has a collection view in the created alert' do
    basic_alert_controller = @vc.rmq.alert('simple message')
    basic_alert_controller.rmq(UICollectionView).size.should == 1
  end

  describe "features of a default alert" do

    before do
      @basic_alert_controller = rmq.alert(message: 'my message', actions: :yes_no)
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
      @basic_alert_controller = rmq.alert(message: 'my message', actions: :yes_no)
    end

    it 'has the corect values int he right places for :yes_no' do
      # Default title
      @basic_alert_controller.rmq(UILabel)[0].get.text.should == "Alert!"
      # Assigned message
      @basic_alert_controller.rmq(UILabel)[1].get.text.should == 'my message'
    end

  end
end