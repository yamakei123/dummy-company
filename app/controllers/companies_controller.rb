class CompaniesController < ApplicationController
  def index
    # TODO: pagenation
    render json: Company.all
  end

  def create
    company = Company.create(create_params)
    if company.valid?
      render status: 201, json: company
    else
      render status: 400, json: { error: company.errors.full_messages }
    end
  end

  def update
    company = Company.find(params[:id])
    company.update(update_params)
    if company.valid?
      render status: 204
    else
      render status: 400, json: { error: company.errors.full_messages }
    end
  end

  def destroy
    company = Company.find(params[:id])
    company.destroy!

    render status: 204
  rescue ActiveRecord::RecordNotFound
    render  status: 422, json: { error: "Company is not found." }
  end

  private

    def create_params
      params.require(:company).
        permit(
          :code,
          :name
        )
    end

    def update_params
      params.require(:company).
        permit(
          :name
        )
    end
end
