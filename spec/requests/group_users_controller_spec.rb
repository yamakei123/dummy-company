require "rails_helper"

RSpec.describe GroupUsersController, :type => :request do
  let(:company) {
    create(:company, code: "1234567-BA")
  }
  let!(:group) {
    create(:group, company_id: company.id)
  }
  let!(:user) {
    create(:user, company_id: company.id)
  }

  describe "#create" do
    let(:params) {
      {
        group_user: {
          user_id: user.id,
          group_id: group.id
        }
      }
    }

    context "normal request" do
      it "success" do
        post "/companies/#{company.id}/group_users", params: params

        expect(response).to have_http_status(201)
      end
    end
  end

  describe "#destroy" do
    let!(:group_user) {
      create(:group_user, group_id: group.id, user_id: user.id)
    }

    context "normal request" do
      it "success" do
        delete "/companies/#{company.id}/group_users/#{group_user.id}"

        expect(response).to have_http_status(204)
      end
    end
  end
end