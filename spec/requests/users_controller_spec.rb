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

    context "irregular request" do
      let(:email) { "test@sample1.co.jp" }
      let(:first_name) { "taro" }
      let(:last_name) { "test" }
      let(:age) { 29 }
      let(:params) {
        {
          user: {
            first_name: first_name,
            last_name: last_name,
            email: email,
            age: age
          }
        }
      }

      context "not email" do
        let(:email) { "test" }

        it "success" do
          post "/companies/#{company.id}/users", params: params

          expect(response).to have_http_status(400)
        end
      end

      context "first_name is 51 length." do
        let(:first_name) { "123456789012345678901234567890123456789012345678901" }

        it "success" do
          post "/companies/#{company.id}/users", params: params

          expect(response).to have_http_status(400)
        end
      end

      context "last_name is 51 length." do
        let(:last_name) { "123456789012345678901234567890123456789012345678901" }

        it "success" do
          post "/companies/#{company.id}/users", params: params

          expect(response).to have_http_status(400)
        end
      end

      context "Under 18 years old" do
        let(:age) { 17 }

        it "success" do
          post "/companies/#{company.id}/users", params: params

          expect(response).to have_http_status(400)
        end
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

    context "irregular request" do
      let(:email) { "test@sample1.co.jp" }
      let(:first_name) { "taro" }
      let(:last_name) { "test" }
      let(:age) { 29 }
      let(:params) {
        {
          user: {
            first_name: first_name,
            last_name: last_name,
            email: email,
            age: age
          }
        }
      }
      let!(:user) {
        create(:user, company_id: company.id)
      }

      context "first_name is 51 length." do
        let(:first_name) { "123456789012345678901234567890123456789012345678901" }

        it "success" do
          patch "/companies/#{company.id}/users/#{user.id}", params: params

          expect(response).to have_http_status(400)
        end
      end

      context "last_name is 51 length." do
        let(:last_name) { "123456789012345678901234567890123456789012345678901" }

        it "success" do
          patch "/companies/#{company.id}/users/#{user.id}", params: params

          expect(response).to have_http_status(400)
        end
      end

      context "Under 18 years old" do
        let(:age) { 17 }

        it "success" do
          patch "/companies/#{company.id}/users/#{user.id}", params: params

          expect(response).to have_http_status(400)
        end
      end
    end
  end
end