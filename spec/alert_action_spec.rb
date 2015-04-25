describe "AlertAction" do

  A = RubyMotionQuery::AlertAction

  describe "#style" do

    it "should default to :default" do
      A.new.style.should == :default
    end

    it "should prevent rogue choices" do
      A.new(style: 'lol').style.should == :default
      A.new(style: :lol).style.should == :default
      A.new(style: nil).style.should == :default
    end

    it "should only allow valid choices" do
      A::VALID_STYLES.each do |x|
        A.new(style: x).style.should == x
      end
    end

    it "should know the convenience boolean getters" do
      A.new(style: :default).default?.should == true
      A.new(style: :destructive).destructive?.should == true
      A.new(style: :cancel).cancel?.should == true
    end

  end

  describe "#title" do

    it "should remember our selection" do
      A.new(title: "foo").title.should == "foo"
    end

    it "should default to OK" do
      A.new.title.should == "OK"
    end

    it "should be set when we new up with a string" do
      A.new("hi").title.should == "hi"
    end

  end

  describe "#tag" do

    it "should pickup the default from the title" do
      A.new(title: "foo").tag.should == :foo
    end

    it "should not be overriden by a title when set" do
      A.new(title: "foo", tag: :bar).tag.should == :bar
    end

    it "should down case titles" do
      A.new(title: "FOO").tag.should == :foo
    end

    it "should camel case titles" do
      A.new(title: "happy fun ball").tag.should == :happy_fun_ball
    end

  end

end
