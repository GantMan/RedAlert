describe "RedAlert.custom_fieldset" do
  field = {
    phone: {placeholder: 'Phone', keyboard_type: :phone_pad}
  }
  fields = {
    phone: {placeholder: 'Phone', keyboard_type: :phone_pad},
    email: {placeholder: 'Email', secure: false, keyboard_type: :email_address}
  }

  three_fields = {
    phone: {placeholder: 'Phone', keyboard_type: :phone_pad},
    email: {placeholder: 'Email', secure: false, keyboard_type: :email_address},
    name: {placeholder: 'Name', secure: false, keyboard_type: :default}
  }

  it 'should set the default api argument to :modern' do
    subject = RubyMotionQuery::App.custom_fieldset( fields )
    subject[:alert_view_style].should == UIAlertViewStyleDefault
  end

  it 'should prevent being called without providing at least one field' do
    Proc.new {  RubyMotionQuery::App.custom_fieldset(nil) }.should.raise(ArgumentError)
  end

  describe ':deprecated api' do

    it 'should set the expected alert_view_style for 1 field' do
      subject = RubyMotionQuery::App.custom_fieldset( :deprecated, field )
      subject[:alert_view_style].should == UIAlertViewStylePlainTextInput
    end

    it 'should set the expected alert_view_style for 2 fields' do
      subject = RubyMotionQuery::App.custom_fieldset( :deprecated, fields )
      subject[:alert_view_style].should == UIAlertViewStyleLoginAndPasswordInput
    end

    it 'should prevent passing in more than 2 fields' do
      Proc.new {  RubyMotionQuery::App.custom_fieldset(:deprecated, three_fields) }.should.raise(ArgumentError)
    end

  end

  describe ':modern api' do

    it 'should allow passing in more than 2 fields' do
      Proc.new {  RubyMotionQuery::App.custom_fieldset(:modern, three_fields) }.should.not.raise(ArgumentError)
    end

  end

  describe 'fields' do

    it 'should create 2 AlertFields' do
      subject = RubyMotionQuery::App.custom_fieldset( fields )
      subject[:fields].count.should == 2

      phone = subject[:fields][0]
      phone.class.should == RubyMotionQuery::AlertField
      phone.name.should == fields.keys[0]
      phone.keyboard_type.should == fields.values[0][:keyboard_type]
      phone.placeholder.should == fields.values[0][:placeholder]

      email = subject[:fields][1]
      email.class.should == RubyMotionQuery::AlertField
      email.name.should == fields.keys[1]
      email.keyboard_type.should == fields.values[1][:keyboard_type]
      email.placeholder.should == fields.values[1][:placeholder]
    end

  end

end
