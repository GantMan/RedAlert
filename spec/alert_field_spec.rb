describe "AlertField" do

  af = RubyMotionQuery::AlertField

  describe "#name" do

    it "should prevent being called without a name argument" do
      Proc.new { af.new(nil) }.should.raise(ArgumentError)
    end

    it "should create a symbolized name from a string argument" do
      af.new('this is a field').name.should == :this_is_a_field
    end

    it 'should accept a symbol for the name argument' do
      af.new(:this_is_a_field).name.should == :this_is_a_field
    end

  end

  describe "keyboard_type" do

    it 'should accept valid keyboard types' do
      RubyMotionQuery::Stylers::KEYBOARD_TYPES.each do |key, value|
        af.new(:name, keyboard_type: key).keyboard_type.should == key
      end
    end

    it 'should prevent rogue choices' do
      af.new(:name, keyboard_type: :teeny).keyboard_type.should == :default
      af.new(:name, keyboard_type: 'teeny').keyboard_type.should == :default
      af.new(:name, keyboard_type: nil).keyboard_type.should == :default
    end

  end

  describe "#placeholder" do

    it "should be set to the opts argument if it is a string" do
      af.new(:name, "Your Name").placeholder.should == "Your Name"
    end

    it "should use the placeholder option if provided" do
      af.new(:name, placeholder: "Your Name").placeholder.should == "Your Name"
    end

    it "should set the placeholder to an empty string if not provided" do
      af.new(:name).placeholder.should == ""
    end

  end

  describe "#text" do

    it "should use the text option if provided" do
      af.new(:name, text: "Gant").text.should == "Gant"
    end

    it "should set the text to an empty stringif not provided" do
      af.new(:name).text.should == ""
    end

  end

  describe "#secure_text_entry" do

    it "should default to false" do
      af.new(:name).secure_text_entry.should == false
    end

    it "should use the secure option if provided" do
      af.new(:name, secure_text_entry: true).secure_text_entry.should == true
    end

  end

end
