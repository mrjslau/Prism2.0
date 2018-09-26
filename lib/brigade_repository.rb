# lib/brigade_repository.rb

# BrigadeRepository class is acting as a database
# for the Brigade entity
# It contains
class BrigadeRepository
  def get
    Brigade.new
  end
end
