class Api::ContactsController < ApplicationController

  def index
    @contacts = current_user.contacts
    if params[:search]
      @contacts = @contacts.where("first_name iLIKE ? OR middle_name iLIKE ? OR last_name iLIKE ? OR email iLIKE ? OR phone_number iLIKE ? OR bio iLIKE ? OR address iLIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    end
    if params[:group]
      group = Group.find_by(name: params[:group])
      @contacts = group.contacts.where(user_id: current_user.id)
    end
    if params[:first_name]
      @contacts = @contacts.where("first_name iLIKE ?", "%#{params[:first_name]}%")
    end
    if params[:middle_name]
      @contacts = @contacts.where("middle_name iLIKE ?", "%#{params[:middle_name]}%")
    end
    if params[:last_name]
      @contacts = @contacts.where("last_name iLIKE ?", "%#{params[:last_name]}%")
    end
    if params[:email]
      @contacts = @contacts.where("email iLIKE ?", "%#{params[:email]}%")
    end
    if params[:phone_number]
      @contacts = @contacts.where("phone_number iLIKE ?", "%#{params[:phone_number]}%")
    end
    if params[:bio]
      @contacts = @contacts.where("bio iLIKE ?", "%#{params[:bio]}%")
    end
    if params[:address]
      @contacts = @contacts.where("address iLIKE ?", "%#{params[:address]}%")
    end
    render "index.json.jb"
  end

  def show
    @contact = Contact.find_by(id: params[:id])
    render "show.json.jb"
  end
  
  def create
    coordinates = Geocoder.coordinates(params[:address])
    @contact = Contact.new(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      bio: params[:bio],
      address: params[:address],
      latitude: coordinates[0],
      longitude: coordinates[1],
      user_id: current_user.id
    )
    if @contact.save
      render "show.json.jb"
    else
      render json: {errors: @contact.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    @contact = Contact.find_by(id: params[:id])
    if params[:address]
      coordinates = Geocoder.coordinates(params[:address])
      @contact.address = params[:address]
      @contact.latitude = coordinates[0]
      @contact.longitude = coordinates[1]
    end
    @contact.update(
      first_name: params[:first_name] || @contact.first_name,
      middle_name: params[:middle_name] || @contact.middle_name,
      last_name: params[:last_name] || @contact.last_name,
      email: params[:email] || @contact.email,
      phone_number: params[:phone_number] || @contact.phone_number,
      bio: params[:bio] || @contact.bio
    )
    if @contact.save
      render "show.json.jb"
    else
      render json: {errors: @contact.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    @contact = Contact.find_by(id: params[:id])
    @contact.destroy
    render json: {message: "The contact has been deleted."}
  end

end
