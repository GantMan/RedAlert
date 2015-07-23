describe "RubyMotionQuery::App" do
  describe "add_template_fieldset" do

    describe ":input" do

      it "should have 1 field named :text" do
        a = RubyMotionQuery::App.add_template_fieldset(:input)
        a[:alert_view_style].should == UIAlertViewStylePlainTextInput
        a[:fields].count.should == 1
        field = a[:fields].first
        field.name.should == :text
        field.keyboard_type.should == :default
        field.secure_text_entry.should == false
        field.placeholder.should == ""
      end

    end

    describe ":secure" do

      it "should have 1 field named :text" do
        a = RubyMotionQuery::App.add_template_fieldset(:secure)
        a[:alert_view_style].should == UIAlertViewStyleSecureTextInput
        a[:fields].count.should == 1
        field = a[:fields].first
        field.name.should == :text
        field.keyboard_type.should == :default
        field.secure_text_entry.should == true
        field.placeholder.should == ""
      end

    end

    describe ":login" do

      it "should have 2 fields: :login and :password" do
        a = RubyMotionQuery::App.add_template_fieldset(:login)
        a[:alert_view_style].should == UIAlertViewStyleLoginAndPasswordInput
        a[:fields].count.should == 2
        login = a[:fields][0]
        password = a[:fields][1]
        login.name.should == :login
        login.keyboard_type.should == :email_address
        login.secure_text_entry.should == false
        login.placeholder.should == "Login"
        password.name.should == :password
        password.keyboard_type.should == :default
        password.secure_text_entry.should == true
        password.placeholder.should == "Password"
      end

    end

    describe ":change_password" do

      it "should have 2 fields: :current_password and :new_password" do
        a = RubyMotionQuery::App.add_template_fieldset(:change_password)
        a[:alert_view_style].should == UIAlertViewStyleLoginAndPasswordInput
        a[:fields].count.should == 2
        current_password = a[:fields][0]
        new_password = a[:fields][1]
        current_password.name.should == :current_password
        current_password.keyboard_type.should == :default
        current_password.secure_text_entry.should == true
        current_password.placeholder.should == "Current Password"
        new_password.name.should == :new_password
        new_password.keyboard_type.should == :default
        new_password.secure_text_entry.should == true
        new_password.placeholder.should == "New Password"
      end

    end

  end
end
