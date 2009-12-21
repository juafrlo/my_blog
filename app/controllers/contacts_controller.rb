class ContactsController < ApplicationController
  def index
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(params[:contact])
    @contact.user_ip = request.remote_ip
    @contact.save
  end  
end
