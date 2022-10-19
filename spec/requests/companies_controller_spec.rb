require "rails_helper"

RSpec.describe CompaniesController, :type => :request do
  describe "#index" do
    context "normal request" do

      it "success" do
        create(:company, code: "1234567-BA")
        get "/companies"

        expect(response).to have_http_status(200)
      end
    end
  end

  describe "#create" do
    let(:params) {
      {
        company: {
          name: "test company",
          code: code
        }
      }
    }

    context "normal request" do
      let(:code) { "1234567-aA" }

      it "success" do
        post "/companies", params: params

        expect(response).to have_http_status(201)
      end
    end

    context "code is 51 length" do
      let(:code) { "123456789012345678901234567890123456789012345678901" }

      it "success" do
        post "/companies", params: params

        expect(response).to have_http_status(400)
      end
    end

    context "code is null" do
      let(:code) { nil }

      it "success" do
        post "/companies", params: params

        expect(response).to have_http_status(400)
      end
    end
  end

  describe "#update" do
    let(:params) {
      {
        company: {
          name: "test company"
        }
      }
    }

    context "normal request" do
      let!(:company) {
        create(:company, code: "1234567-aB")
      }

      it "success" do
        patch "/companies/#{company.id}", params: params

        expect(response).to have_http_status(204)
      end
    end
  end
end