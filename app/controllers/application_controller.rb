class ApplicationController < ActionController::API
  private

    def set_company
      @company = Company.find(params[:company_id])
    end
end
