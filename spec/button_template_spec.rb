describe "RubyMotionQuery::App" do
  describe "add_template_actions" do

    describe ":yes_no" do
      it "should have 2 buttons, :yes and :no" do
        a = RubyMotionQuery::App.add_template_actions(:yes_no)
        a.length.should == 2
        a[0].tag.should == :yes
        a[1].tag.should == :no
        a[0].style.should == :default
        a[1].style.should == :default
      end
    end

    describe ":yes_no_cancel" do
      it "should have 3 buttons, :yes, :no, :cancel" do
        a = RubyMotionQuery::App.add_template_actions(:yes_no_cancel)
        a.length.should == 3
        a[0].tag.should == :yes
        a[1].tag.should == :no
        a[2].tag.should == :cancel
        a[0].style.should == :default
        a[1].style.should == :default
        a[2].style.should == :cancel
      end
    end

    describe ":ok_cancel" do
      it "should have 2 buttons, :ok and :cancel" do
        a = RubyMotionQuery::App.add_template_actions(:ok_cancel)
        a.length.should == 2
        a[0].tag.should == :ok
        a[1].tag.should == :cancel
        a[0].style.should == :default
        a[1].style.should == :cancel
      end
    end

    describe ":delete_cancel" do
      it "should have 2 buttons, :delete and :cancel" do
        a = RubyMotionQuery::App.add_template_actions(:delete_cancel)
        a.length.should == 2
        a[0].tag.should == :delete
        a[1].tag.should == :cancel
        a[0].style.should == :destructive
        a[1].style.should == :cancel
      end
    end

  end
end
