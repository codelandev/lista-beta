require "spec_helper"

describe StartupMailer do
  # let(:startup) { Startup.make! }
  let(:startup) { mock_model(Startup, :name => 'Startup de teste', :email => 'startup@test.com') }

  describe "notify_approvation" do
    let(:mail) { StartupMailer.notify_approvation(startup) }

    # ensure that the receiver is correct
    it "renders the receiver email" do
      mail.to.should == [startup.email]
    end

    # ensure that the sender is correct
    it "renders the sender email" do
      mail.from.should == ["no-reply@listabeta.com.br"]
    end

    # ensure that the subject is correct
    it "renders the subject" do
      mail.subject.should == "Sua Startup está na Lista Beta!"
    end

    # ensure that body is correct
    # it "renders the body" do
    #   mail.body.raw_source.should include "Sua Startup foi aprovada!"
    # end
  end
end
