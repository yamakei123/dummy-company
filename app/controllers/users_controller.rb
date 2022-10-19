class UsersController < ApplicationController
  before_action :set_company

  def index
    render json: @company.users
  end

  def create
    # TODO: company_id should be judged by current_user
    user = @company.users.create(create_params)
    if user.valid?
      render status: 201, json: user
    else
      render status: 400, json: { error: user.errors.full_messages }
    end
  end

  def update
    user = @company.users.find(params[:id])
    user.update(update_params)
    if user.valid?
      render status: 204
    else
      render status: 400, json: { error: user.errors.full_messages }
    end
  end

  def destroy
    user = @company.users.find(params[:id])
    user.destroy!

    render status: 204
  rescue ActiveRecord::RecordNotFound
    render  status: 400, json: { error: "User is not found." }
  end

  private

    def create_params
      params.require(:user).
        permit(
          :first_name,
          :last_name,
          :age,
          :email,
          :group_id
        )
    end

    def update_params
      params.require(:user).
        permit(
          :first_name,
          :last_name,
          :age,
          :group_id
        )
    end
end
