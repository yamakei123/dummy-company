class GroupsController < ApplicationController
  before_action :set_company

  def index
    render json: @company.groups
  end

  def create
    # TODO: company_id should be judged by current_user
    group = @company.groups.create(create_params)
    if group.valid?
      render status: 201, json: group
    else
      render status: 400, json: { error: group.errors.full_messages }
    end
  end

  def update
    group = @company.groups.find(params[:id])
    group.update(update_params)
    if group.valid?
      render status: 204
    else
      render status: 400, json: { error: group.errors.full_messages }
    end
  end

  def destroy
    group = @company.groups.find(params[:id])
    group.destroy!

    render status: 204
  rescue ActiveRecord::RecordNotFound
    render  status: 400, json: { error: "Group is not found." }
  end

  private

    def create_params
      params.require(:group).
        permit(
          :name,
          :company_id
        )
    end

    def update_params
      params.require(:group).
        permit(
          :name,
          :company_id
        )
    end
end
