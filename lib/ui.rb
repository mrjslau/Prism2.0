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
@persons = [Person.new('Marijus', 'Laucevicius', 'male', '1996-12-24', Location.new(0.004, 0.004)),
            Person.new('Benas', 'Bagdanovas', 'male', '1996-01-01', Location.new(0.006, 0)),
            Person.new('Justas', 'Lakstinis', 'male', '1997-01-01', Location.new(5.0002, 5)),
            Person.new('Adriana', 'Leisyte', 'female', '1997-01-01', Location.new(10, 0)),
            Person.new('Marius', 'Kurbakovas', 'male', '1997-01-01', Location.new(10, 0))]

@persons[0].add_pet(Location.new(0, 0))
@persons[0].add_pet(Location.new(0.002, 0.002))
@persons[1].add_pet(Location.new(5, 5))
@persons[3].add_pet(Location.new(11, 0))

@persons[0].add_phone(@persons[0].location)
@persons[1].add_phone(Location.new(0.0003, 0.001))
@persons[2].add_phone(Location.new(5, 5))
@persons[2].add_phone(Location.new(5.0001, 5))
@persons[3].add_phone(Location.new(11, 0))
@persons[4].add_phone(@persons[4].location)

action = 1
puts 'Welcome to Prism2.0'
while action != 0
  puts "\n Choose your next action:"
  puts '1 - neighborhoods, 2 - people, 3 - pets, 4 - phones, 0 - exit'
  action = gets.chomp

  case action

  # NEIGHBORHOOD ACTIONS  
  when '1'
    @city.neighborhoods.each do |n|
      puts "\t" + n.name
    end

  # PERSON ACTIONS  
  when '2'
    paction = 1
    @map.residents.each do |n|
      puts "\t" + n.identity.name + ' ' + n.identity.surname + ' , location: ' + n.location.to_s
    end
    while paction != 0
      puts "\n \t Choose your next action:"
      puts "\t 1 - change location, 2 - add phone, 3 - remove phone, 4 - check if there are any phones nearby, 5 - does person have any phones?, 6 - add pet, 7 - remove pets, 8 - does person have any pet? 9 - person's status, 10 - list all residents, 0 - go back"
      paction = gets.chomp

      case paction
      when '1'
        puts "\n \t \t Enter person's first name"
        name = gets.chomp
        puts "\n \t \t Enter new latitude"
        lat = gets.chomp.to_f
        puts "\n \t \t Enter new longitude"
        lon = gets.chomp.to_f
        @map.residents.each do |n|
          if n.identity.name.casecmp?(name)
            n.change_location(Location.new(lat, lon))
            break
          end
        end
      when '2'
        puts "\n \t \t Enter person's first name"
        name = gets.chomp
        puts "\n \t \t Enter latitude for a new phone"
        lat = gets.chomp.to_f
        puts "\n \t \t Enter longitude for a new phone"
        lon = gets.chomp.to_f
        @map.residents.each do |n|
          if n.identity.name.casecmp?(name)
            n.add_phone(Location.new(lat, lon))
            break
          end
        end
      when '3'
        puts "\n \t \t Enter person's first name"
        name = gets.chomp
        @map.residents.each do |n|
          if n.identity.name.casecmp?(name)
            n.remove_phones
            puts "\n \t \t \t " + n.identity.name + "'s phones removed. \n"
          end
        end
      when '4'
        puts "\n \t \t Enter person's first name"
        name = gets.chomp
        @map.residents.each do |n|
          if n.identity.name.casecmp?(name)
            if n.near_any_phone?
              puts "\n \t \t \t There are phones nearby " + n.identity.name + " at distances:"
              n.belongings.fetch(:phones).each do |p|
                puts "\t \t \t " + p.location.calculate_distance(n.location).to_s + 'meters.'
              end
              puts "\n"
            else
              puts "\n \t \t \t There are no phones nearny " + n.identity.name + ". \n"
            end
          end
        end
      when '5'
        puts "\n \t \t Enter person's first name"
        name = gets.chomp
        @map.residents.each do |n|
          if n.identity.name.casecmp?(name)
            if n.phones?
              puts "\n \t \t \t " + n.identity.name + " have phones at locations:"
              n.belongings.fetch(:phones).each do |p|
                puts "\t \t \t " + p.location.to_s
              end
              puts "\n"
            else
              puts "\n \t \t \t " + n.identity.name + " doesn't have any phones. \n"
            end
          end
        end
      when '6'
        puts "\n \t \t Enter person's first name"
        name = gets.chomp
        puts "\n \t \t Enter latitude for a new pet"
        lat = gets.chomp.to_f
        puts "\n \t \t Enter longitude for a new pet"
        lon = gets.chomp.to_f
        @map.residents.each do |n|
          if n.identity.name.casecmp?(name)
            n.add_pet(Location.new(lat, lon))
            break
          end
        end
      when '7'
        puts "\n \t \t Enter person's first name"
        name = gets.chomp
        @map.residents.each do |n|
          if n.identity.name.casecmp?(name)
            n.remove_pets
            puts "\n \t \t \t " + n.identity.name + "'s pets removed. \n"
          end
        end
      when '8'
        puts "\n \t \t Enter person's first name"
        name = gets.chomp
        @map.residents.each do |n|
          if n.identity.name.casecmp?(name)
            if n.pets?
              puts "\n \t \t \t " + n.identity.name + " have pets at locations:"
              n.belongings.fetch(:pets).each do |p|
                puts "\t \t \t " + p.location.to_s
              end
              puts "\n"
            else
              puts "\n \t \t \t " + n.identity.name + " doesn't have any pets. \n"
            end
          end
        end
      when '9'
        puts "\n \t \t Enter person's first name"
        name = gets.chomp
        @map.residents.each do |n|
          if n.identity.name.casecmp?(name)
            puts "\n \t \t \t " + n.identity.name + ' is ' + n.status + "\n"
          end
        end
      when '10'
        @map.residents.each do |n|
          puts "\t" + n.identity.name + ' ' + n.identity.surname + ' , location: ' + n.location.to_s
        end
      when '0'
        break
      end
    end

  # EXIT  
  when '0'
    puts 'Goodbye!'
    return
  end
end
