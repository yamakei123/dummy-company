require "rails_helper"

RSpec.describe GroupsController, :type => :request do
  let(:company) {
    create(:company, code: "1234567-BA")
  }
  describe "#index" do
    before do
      create(:group, company_id: company.id)
    end

    context "normal request" do
      it "success" do
        get "/companies/#{company.id}/groups"

        expect(response).to have_http_status(200)
      end
    end
  end

  describe "#create" do
    let(:params) {
      {
        group: {
          name: "B group"
        }
      }
    }

    context "normal request" do
      it "success" do
        post "/companies/#{company.id}/groups", params: params

        expect(response).to have_http_status(201)
      end
    end
  end

  describe "#update" do
    let(:params) {
      {
        group: {
          name: "C group"
        }
      }
    }

    context "normal request" do
      let!(:group) {
        create(:group, company_id: company.id)
      }

      it "success" do
        patch "/companies/#{company.id}/groups/#{group.id}", params: params

        expect(response).to have_http_status(204)
      end
    end
  end
end