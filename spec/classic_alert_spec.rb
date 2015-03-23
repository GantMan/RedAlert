describe 'ClassicAlert' do

  before do
    @rmq = RubyMotionQuery::RMQ.new
  end

  it 'should return the created alert view' do
    view = @rmq.app.alert_view(title: 'fresh title', message: 'simple message', show_now: false)
    view.is_a?(UIAlertView).should.be.true
    view.title.should.equal('fresh title')
    view.message.should.equal('simple message')
    view.cancelButtonIndex.should.equal(0)
    view.numberOfButtons.should.equal(1)
  end

end