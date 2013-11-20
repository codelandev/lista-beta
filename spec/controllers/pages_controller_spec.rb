require 'spec_helper'

describe PagesController do
  context "When Signed In" do
    describe "GET home" do
      it "return 200" do
        get :home
        expect(response.status).to eql 200
      end
    end

    describe "GET markets" do
      before do
        @startup ||= Startup.make!(status: Status::APPROVED)
      end

      it "and not assign startup when pass no :tag" do
        get :markets
        expect(response.status).to eql 200
        expect(assigns(:markets)).not_to include(@startup)
        expect(assigns(:markets)).to include(Startup.tag_counts_on(:markets)[1])
      end

      it "and assign startup when pass no :tag" do
        get :markets, tag: 'Startups'
        expect(response.status).to eql 200
        expect(assigns(:startups)).to include(@startup)
        expect(assigns(:startups)).not_to include(Startup.tag_counts_on(:markets)[1])
      end
    end

    describe "GET dashboard" do
      before do
        @startup ||= Startup.make!
        sign_in @startup
      end

      it "assign feedbacks_total" do
        get :dashboard
        expect(assigns(:feedbacks_total)).to eql Questionnaire.where(startup: @startup).count
      end
    end
  end

  context "When Signed Out" do
    describe "GET home" do
      it "return 200" do
        get :home
        expect(response.status).to eql 200
      end
    end

    describe "GET markets" do
      before do
        @startup ||= Startup.make!(status: Status::APPROVED)
      end

      it "and not assign startup when pass no :tag" do
        get :markets
        expect(response.status).to eql 200
        expect(assigns(:markets)).not_to include(@startup)
        expect(assigns(:markets)).to include(Startup.tag_counts_on(:markets)[1])
      end

      it "and assign startup when pass no :tag" do
        get :markets, tag: 'Startups'
        expect(response.status).to eql 200
        expect(assigns(:startups)).to include(@startup)
        expect(assigns(:startups)).not_to include(Startup.tag_counts_on(:markets)[1])
      end
    end

    describe "GET dashboard" do
      it "return success" do
        get :dashboard
        response.should redirect_to new_startup_session_path
      end
    end
  end
end
