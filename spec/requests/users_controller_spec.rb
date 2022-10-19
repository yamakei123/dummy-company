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
          code: "1234567-aA"
        }
      }
    }

    context "normal request" do
      it "success" do
        post "/companies", params: params

        expect(response).to have_http_status(201)
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