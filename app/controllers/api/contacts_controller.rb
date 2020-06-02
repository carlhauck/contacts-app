class Api::ContactsController < ApplicationController

  def index
    @contacts = Contact.all
    render "index.json.jb"
  end

  def show
    @contact = Contact.find_by(id: params[:id])
    render "show.json.jb"
  end
  
  def create
    @contact = Contact.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number]
    )
    @contact.save
    render "show.json.jb"
  end

  def update
    @contact = Contact.find_by(id: params[:id])
    @contact.update(
      first_name: params[:first_name] || @contact.first_name,
      last_name: params[:last_name] || @contact.last_name,
      email: params[:email] || @contact.email,
      phone_number: params[:phone_number] || @contact.phone_number
    )
    @contact.save
    render "show.json.jb"
  end

  def destroy
    @contact = Contact.find_by(id: params[:id])
    @contact.destroy
    render json: {message: "The contact has been deleted."}
  end

end
