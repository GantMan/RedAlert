describe 'AlertAction' do
  aa = RubyMotionQuery::AlertAction

  describe '#style' do
    it 'should default to :default' do
      aa.new.style.should == :default
    end

    it 'should prevent rogue choices' do
      aa.new(style: 'lol').style.should == :default
      aa.new(style: :lol).style.should == :default
      aa.new(style: nil).style.should == :default
    end

    it 'should only allow valid choices' do
      RubyMotionQuery::AlertAction::VALID_STYLES.each do |x|
        aa.new(style: x).style.should == x
      end
    end

    it 'should know the convenience boolean getters' do
      aa.new(style: :default).default?.should == true
      aa.new(style: :destructive).destructive?.should == true
      aa.new(style: :cancel).cancel?.should == true
    end
  end

  describe '#title' do
    it 'should remember our selection' do
      aa.new(title: 'foo').title.should == 'foo'
    end

    it 'should default to OK' do
      aa.new.title.should == 'OK'
    end

    it 'should be set when we new up with a string' do
      aa.new('hi').title.should == 'hi'
    end
  end

  describe '#tag' do
    it 'should pickup the default from the title' do
      aa.new(title: 'foo').tag.should == :foo
    end

    it 'should not be overriden by a title when set' do
      aa.new(title: 'foo', tag: :bar).tag.should == :bar
    end

    it 'should down case titles' do
      aa.new(title: 'FOO').tag.should == :foo
    end

    it 'should camel case titles' do
      aa.new(title: 'happy fun ball').tag.should == :happy_fun_ball
    end
  end
end
