class Api::GroupsController < ApplicationController

  def create
    @group = Group.new(
      name: params[:name]
    )
    if @group.save
      render json: {message: "Group created successfully."}
    else
      render json: {errors: @group.errors.full_messages}, status: :unprocessable_entity
    end
  end

end
