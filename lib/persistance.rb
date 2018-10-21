require 'yaml/store'

## persistance/persistance.rb

# Persistance class allows storing and reading the state of the system
class Persistance
  attr_reader :store

  def initialize(file_name)
    @store = YAML::Store.new(file_name)
  end

  def store_data(data)
    store.transaction do
      store.abort unless data && data.instance_of?(Map)
      store[:data] = data
    end
  end

  def fetch_data
    store.transaction { store[:data] }
  end
end
