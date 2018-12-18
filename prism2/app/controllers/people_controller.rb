# People controller
class PeopleController < ApplicationController
  def index
    @people = Person.all
  end

  def new
    @person = Person.new
 end

  def create

    @person = Person.new(person_params)

    if @person.save
      redirect_to '/identities/new'
    else
      flash[:errors] = @person.errors.full_messages
      redirect_to '/people/new'
    end

  end

  def person_params
    params.require(:person).permit(:map_id)
  end

end
