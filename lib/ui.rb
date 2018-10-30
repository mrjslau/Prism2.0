# lib/ui.rb

require_relative 'ambulance'
require_relative 'brigade'
require_relative 'building'
require_relative 'city'
require_relative 'drone'
require_relative 'gate_barrier'
require_relative 'identity'
require_relative 'intersection'
require_relative 'location'
require_relative 'map'
require_relative 'neighborhood'
require_relative 'notification'
require_relative 'person'
require_relative 'police'
require_relative 'phone'
require_relative 'pet'
require_relative 'traffic_light'
require_relative 'user'
require_relative 'vehicle'

# Command line UI file
@map = Map.instance
@city = City.new('Vilnius')
@neighborhoods = [Neighborhood.new('Senamiestis', @city),
                  Neighborhood.new('Naujamiestis', @city),
                  Neighborhood.new('Baltupiai', @city)]

puts 'Welcome to Prism2.0'
puts 'Choose your next action'
action = gets.chomp
case action
when 'lists'
  @neighborhoods.each do |n|
    puts n.name
  end
end
