class Api::ContactgroupsController < ApplicationController

  def create
    @contactgroup = ContactGroup.new(
      contact_id: params[:contact_id],
      group_id: params[:group_id]
    )
    if @contactgroup.save
      render json: {message: "Contact group created successfully"}
    else
      render json: {error: @contactgroup.errors.full_messages}, status: :unprocessable_entity
    end
  end

end
