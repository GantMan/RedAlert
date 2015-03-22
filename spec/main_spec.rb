describe "Application 'red_alert'" do
  before do
    #@app = UIApplication.sharedApplication
    @app = RubyMotionQuery::App
    @vc = @app.windows.first.rootViewController
  end

  it "has at least one window" do
    @app.windows.size.should >= 1
  end

  it "has lots of buttons" do
    @vc.rmq(UIButton).size.should > 10
  end
end
