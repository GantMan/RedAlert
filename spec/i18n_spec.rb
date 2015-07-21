return unless rmq.device.ios_at_least?(8)

class French
  class << self
    attr_writer :enabled

    def enabled?
      @enabled || false
    end
  end
end


class Kernel
  def NSLocalizedString(key, comment)
    if French.enabled?
      path =  NSBundle.mainBundle.pathForResource('fr', ofType:"lproj" )
      bundle = NSBundle.bundleWithPath(path)
      bundle.localizedStringForKey(key, value:comment, table:nil)
    else
      key
    end
  end
end

describe 'RedAlert' do

  describe "i18n capability" do

    describe "When in Englishland" do

      before do
        @ac = rmq.app.alert(message: 'yes_no_cancel', style: :login, actions: :yes_no_cancel, show_now: false).alert_controller
      end

      it "should have the correct title" do
        @ac.title.should == nil
      end

      it "should have the assigned message" do
        @ac.message.should == "yes_no_cancel"
      end

      it "should have an english Yes button" do
        @ac.actions[0].title.should == "Yes"
      end

      it "should have an english No button" do
        @ac.actions[1].title.should == "No"
      end

      it "should have an english Cancel button" do
        @ac.actions[2].title.should == "Cancel"
      end

      it 'should have English placeholder text for the first field' do
        @ac.textFields[0].placeholder.should == "Login"
      end

      it 'should have English placeholder text for the second field' do
        @ac.textFields[1].placeholder.should == "Password"
      end

    end

    describe "When in Frenchland" do

      before do
        French.enabled = true
        @ac = rmq.app.alert(message: 'yes_no_cancel', style: :login, actions: :yes_no_cancel, show_now: false).alert_controller
      end

      after do
        French.enabled = false
      end

      it "should have the correct title" do
        @ac.title.should == nil
      end

      it "should have the assigned message" do
        @ac.message.should == "yes_no_cancel"
      end

      it "should have an english Yes button" do
        @ac.actions[0].title.should == "Oui"
      end

      it "should have an english No button" do
        @ac.actions[1].title.should == "Pas"
      end

      it "should have an english Cancel button" do
        @ac.actions[2].title.should == "Annuler"
      end

      it 'should have French placeholder text for the first field' do
        @ac.textFields[0].placeholder.should == "S'identifier"
      end

      it 'should have French placeholder text for the second field' do
        @ac.textFields[1].placeholder.should == "Mot De Passe"
      end

    end
  end

end
