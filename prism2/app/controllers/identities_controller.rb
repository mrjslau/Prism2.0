# Identity controller
class IdentitiesController < ApplicationController

  def index
    @identities = Identity.all
  end

  def new
    @identity = Identity.new
  end

  def create
    @identity = Identity.new(identity_params)
    @identity.person_id = Person.last.id

    if @identity.save
      redirect_to "/maps/#{@identity.person.map.id}"
    else
      flash[:errors] = @identity.errors.full_messages
      redirect_to '/identities/new'
    end
  end

  private

  def identity_params
    params.require(:identity).permit(:full_name, :birthday, :gender)
  end

end
