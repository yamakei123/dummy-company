class GroupUsersController < ApplicationController
  before_action :set_company
  before_action :find_group, only: :create

  def create
    group_user = @group.group_users.create(create_params)
    if group_user.valid?
      render status: 201, json: group_user
    else
      render json: 400, json: { error: group_user.errors.full_messages }
    end
  rescue ActiveRecord::RecordNotFound
    render  status: 422, json: { error: "Group is not found." }
  end

  def destroy
    group_user = @company.group_users.find(params[:id])
    group_user.destroy!

    render status: 204
  rescue ActiveRecord::RecordNotFound
    render  status: 422, json: { error: "Group User is not found." }
  end

  private

    def find_group
      @group = @company.groups.find(create_params[:group_id])
    end

    def create_params
      params.require(:group_user).
        permit(
          :group_id,
          :user_id
        )
    end
end
