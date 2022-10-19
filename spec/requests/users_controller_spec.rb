require "rails_helper"

RSpec.describe UsersController, :type => :request do
  let(:company) {
    create(:company, code: "1234567-BA")
  }
  describe "#index" do
    before do
      create(:user, company_id: company.id)
    end

    context "normal request" do
      it "success" do
        get "/companies/#{company.id}/users"

        expect(response).to have_http_status(200)
      end
    end
  end

  describe "#create" do
    let(:params) {
      {
        user: {
          first_name: "taro",
          last_name: "test",
          email: "test@sample1.co.jp",
          age: 29
        }
      }
    }

    context "normal request" do
      it "success" do
        post "/companies/#{company.id}/users", params: params

        expect(response).to have_http_status(201)
      end
    end
  end

  describe "#update" do
    let(:params) {
      {
        user: {
          first_name: "taro",
          last_name: "test",
          age: 29
        }
      }
    }

    context "normal request" do
      let!(:user) {
        create(:user, company_id: company.id)
      }

      it "success" do
        patch "/companies/#{company.id}/users/#{user.id}", params: params

        expect(response).to have_http_status(204)
      end
    end
  end
end