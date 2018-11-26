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
require_relative 'persistance'

require 'colorize' # colored text
require 'io/console' # get char from console

class UI
  attr_reader :persistance, :map, :people, :hoods
  def initialize
    @persistance = Persistance.new('saved_data.yml')
    @map = persistance.fetch_data
    @people = map.residents
    @hoods = map.cities[0].neighborhoods
  end

  def display_team_logo(show_title)
    clear_console

    if show_title
        puts '
        _______ _______________________ _______      _______   _______ 
        (  ____ (  ____ \\__   __(  ____ (       )    / ___   ) (  __   )
        | (    )| (    )|  ) (  | (    \\| () () |    \\/   )  | | (  )  |
        | (____)| (____)|  | |  | (_____| || || |        /   ) | | /   |
        |  _____|     __)  | |  (_____  | |(_)| |      _/   /  | (/ /) |
        | (     | (\\ (     | |        ) | |   | |     /   _/   |   / | |
        | )     | ) \\ \\____) (__/\\____) | )   ( |    (   (__/\\_|  (__) |
        |/      |/   \\__\\_______\\_______|/     \\|    \\_______(_(_______)
        '.light_magenta
    end

    puts "\n"\
    " ____  _       _       []  _ _                       _     _                       \n"\
    "/ ___|| |_ ___| |__    __ (_|_)_ __ ___   ___    ___(_)___| |_ ___ _ __ ___   __ _ \n"\
    "\\___ \\| __/ _ \\ '_ \\ / _ \\| | | '_ ` _ \\ / _ \\  / __| / __| __/ _ \\ '_ ` _ \\ / _` |\n"\
    " ___) | ||  __/ |_) |  __/| | | | | | | | (_) | \\__ \\ \\__ \\ ||  __/ | | | | | (_| |\n"\
    "|____/ \\__\\___|_.__/ \\___|/ |_|_| |_| |_|\\___/  |___/_|___/\\__\\___|_| |_| |_|\\__,_|\n"\
    "                        |__/                                                       \n".light_yellow
  end

  def display_message(text, text_color = nil, background_color = nil)
    if (text_color && background_color)
      puts text.colorize(:color => text_color, :background => background_color)
    elsif (text_color)
      puts text.colorize(:color => text_color)
    else
      puts text
    end
  end

  def display_options(heading, options, active_choice)
    display_message(heading, :light_yellow)
    options.each_with_index do |value, index|
      if index == active_choice
        display_message(value, :black, :light_white)
      else
        display_message(value)
      end
    end
    puts "\n"
    puts "\n"
    puts "\n"
  end

  def display_colors
    clear_console

    puts "white".white
    puts "light_white".light_white
    puts "yello".yellow
    puts "light_yellow".light_yellow
    puts "blue".blue
    puts "light_blue".light_blue
    puts "red".red
    puts "light_red".light_red
    puts "green".green
    puts "light_green".light_green
    puts "black".black
    puts "ligh_black".light_black
    puts "magenta".magenta
    puts "light_magenta".light_magenta
    puts "cyan".cyan
    puts "light_cyan".light_cyan
  end

  def display_static_list(heading, items)
    display_message(heading, :cyan)
    items.each_with_index do |value, index|
      display_message("#{index + 1}. #{value}", :light_cyan, :black)
    end
    puts "\n"
  end

  def clear_console
    Gem.win_platform? ? (system "cls") : (system "clear")
  end

  def show_owners_and_pets
    display_message('Currently observed pets grouped by owners:', :cyan)
    puts "\n"

    formatted = format_pets
    formatted.keys.each do |person_id|
      person = people[person_id]
      puts "#{person_id + 1}. #{person.identity.name} #{person.identity.surname}".light_cyan

      item = formatted[person_id]
      names = item[:names]
      locations = item[:locations]
      distances = item[:distances]

      locations.each_with_index do |loc, index|
        puts "\t" + names[index].yellow
        puts "\t" + "Current location:".light_white + "  #{loc}"
        puts "\t" + "Distance to owner:".light_white + " #{distances[index]}"
        puts "\n"
      end
    end
  end

  def show_main_menu
    heading = 'Choose what to observe:'
    choices = [
      'Neighborhoods',
      'People',
      'Pets',
      'Phones',
      'Exit'
    ]
    choice = 0

    while (true)
      clear_console
      display_team_logo(true)
      display_options(heading, choices, choice)
      key = STDIN.getch

      if key == KEYS[:OK]
        show_neighborhood_actions() if choice == 0
        show_person_actions() if choice == 1
        show_pet_actions() if choice == 2
        return if choice == 4
      end

      if key == KEYS[:UP] || key == KEYS[:DOWN]
        choice = change_choice(key, choice, choices.count) 
      end
      return if key == KEYS[:CANCEL]
    end
  end
    
  def show_neighborhood_actions
    neighborhoods = format_neighborhoods
    item_heading = 'Currently observed neighborhoods:'
    main_heading = ''
    choices = ['Back']
    choice = 0

    while (true)
      clear_console
      display_team_logo(false)
      display_static_list(item_heading, neighborhoods)
      display_options(main_heading, choices, choice)
      key = STDIN.getch

      if key == KEYS[:OK]
        return if choice == 0
      end

      if key == KEYS[:UP] || key == KEYS[:DOWN]
        choice = change_choice(key, choice, choices.count) 
      end
      return if key == KEYS[:CANCEL]
    end
  end

  def show_person_actions
    formatted = format_people()
    item_heading = 'Currently observed people:'
    main_heading = ''
    choices = [
      'Add a new person',
      "Change a person's location",
      'Show nearby phones',
      'Back'
    ]
    choice = 0

    while (true)
      clear_console
      display_team_logo(false)
      display_static_list(item_heading, formatted)
      display_options(main_heading, choices, choice)
      key = STDIN.getch

      if key == KEYS[:OK]
        add_new_person if choice == 0
        change_persons_location if choice == 1
        show_nearby_phones if choice == 2
        return if choice == choices.count - 1
        formatted = format_people
      end

      if key == KEYS[:UP] || key == KEYS[:DOWN]
        choice = change_choice(key, choice, choices.count) 
      end
      return if key == KEYS[:CANCEL]
    end
  end

  def show_pet_actions
    main_heading = ''
    choices = [
      'Remove a pet',
      'Back'
    ]
    choice = 0

    while (true)
      clear_console
      display_team_logo(false)
      show_owners_and_pets
      display_options(main_heading, choices, choice)

      key = STDIN.getch
      if key == KEYS[:OK]
        remove_pet if choice == 0
        return if choice == choices.count - 1
      end

      if key == KEYS[:UP] || key == KEYS[:DOWN]
        choice = change_choice(key, choice, choices.count) 
      end
      return if key == KEYS[:CANCEL]
    end
  end

  def add_new_person
    name = ""
    surname = ""
    gender = ""
    gender_regex = /^male$|^female$/
    date = ""
    date_regex = /^\d\d\d\d\-\d\d\-\d\d$/
    lat = 9999
    lon = 9999

    while (true)
      clear_console
      display_team_logo(false)
      display_static_list('Currently observed people:', format_people)

      if name.empty?
        puts "Enter the name of the person:"
        temp = gets.chomp
        next if temp.empty?
        name = temp
        next
      else
        puts 'Name:'.colorize(:color => :black, :background => :light_white)
        puts "#{name}" + "\n\n"
      end

      if surname.empty?
        puts "Enter the surname of the person:"
        temp = gets.chomp
        next if temp.empty?
        surname = temp
        next
      else
        puts 'Surname:'.colorize(:color => :black, :background => :light_white)
        puts "#{surname}" + "\n\n"
      end

      if gender.empty?
        puts "Enter the gender of the person (male/female):"
        temp = gets.chomp
        next if gender_regex.match(temp) == nil
        gender = temp
        next
      else
        puts 'Gender:'.colorize(:color => :black, :background => :light_white)
        puts "#{gender}" + "\n\n"
      end

      if date.empty?
        puts "Enter the date of birth of the person (yyyy-mm-dd):"
        temp = gets.chomp
        next if date_regex.match(temp) == nil
        date = temp
        next
      else
        puts 'Date of birth:'.colorize(:color => :black, :background => :light_white)
        puts "#{date}" + "\n\n"
      end

      if lat == 9999
        puts "Enter the current latitude of the person:"
        temp = gets.chomp.to_f
        next if (temp.is_a? Numeric) == false
        lat = temp
        next
      else
        puts 'Current latitude:'.colorize(:color => :black, :background => :light_white)
        puts "#{lat}" + "\n\n"
      end

      if lon == 9999
        puts "Enter the current latitude of the person:"
        temp = gets.chomp.to_f
        next if (temp.is_a? Numeric) == false
        lon = temp
        next
      else
        puts 'Current longitude:'.colorize(:color => :black, :background => :light_white)
        puts "#{lon}" + "\n\n"
      end

      person = Person.new(name, surname, gender, date,
                          Location.new(lat, lon))
      create_person(person)
      char = STDIN.getch
      return
    end
  end

  def change_persons_location
    formatted = format_people
    person_id = -1
    latitude = -1
    longitude = -1

    while (true)
      clear_console
      display_team_logo(false)
      display_static_list('Currently observed people:', formatted)

      if person_id == -1
        puts "Enter the number of the person:"
        temp = gets.chomp.to_i
        next if (temp.is_a? Numeric) == false
        next if (temp > formatted.count || temp < 1)
        person_id = temp
        next
      else
        puts 'Person:'.colorize(:color => :black, :background => :light_white)
        puts "#{formatted[person_id - 1]}" + "\n\n"
      end
      
      if latitude == -1
        puts "Enter the latitude of the person:"
        temp = gets.chomp.to_f
        next if (temp.is_a? Numeric) == false
        latitude = temp
        next
      else
        puts 'New latitude:'.colorize(:color => :black, :background => :light_white)
        puts "#{latitude}" + "\n\n"
      end

      if longitude == -1
        puts "Enter the longitude of the person:"
        temp = gets.chomp.to_f
        next if (temp.is_a? Numeric) == false
        longitude = temp
        next
      else
        puts 'New longitude:'.colorize(:color => :black, :background => :light_white)
        puts "#{longitude}" + "\n\n"
      end

      location = Location.new(latitude, longitude)
      update_person(person_id - 1, location)
      char = STDIN.getch
      return
    end
  end

  def show_nearby_phones
    formatted = format_people
    person_id = -1

    while (true)
      clear_console
      display_team_logo(false)
      display_static_list('Currently observed people:', formatted)

      if person_id == -1
        puts "Enter the number of the person:"
        temp = gets.chomp.to_i
        next if (temp.is_a? Numeric) == false
        next if (temp > formatted.count || temp < 1)
        person_id = temp
        next
      else
        puts 'Person:'.colorize(:color => :black, :background => :light_white)
        puts "#{formatted[person_id - 1]}" + "\n\n"

        person = people[person_id - 1]
        if person.near_any_phone?
          person.belongings.fetch(:phones).each_with_index do |phone, index|
            puts "Phone #{index + 1}".yellow
            puts "Distance to owner: ".light_white + 
            "#{phone.location.calculate_distance(person.location).to_s} meters \n"
            puts "Turned on? ".light_white + 
            "#{phone.turned_on.to_s} \n"
            puts "Connected? ".light_white +
            "#{phone.connected.to_s}" + "\n\n"
          end
        else
          puts "There are no phones within 50 metres."
        end

        char = STDIN.getch
        return
      end
    end
  end

  def remove_pet
    animal_id = -1
    person_id = -1
    person = nil

    while (true)
      clear_console
      display_team_logo(false)
      show_owners_and_pets

      if person_id == -1
        puts "Enter the number of the person:"
        temp = gets.chomp.to_i
        next if (temp.is_a? Numeric) == false
        next if (temp > people.count || temp < 1)
        person_id = temp
        person = people[person_id - 1]
        next
      else
        puts 'Person:'.colorize(:color => :black, :background => :light_white)
        iden = person.identity
        puts "#{iden.name} #{iden.surname}" + "\n\n"
      end

      if animal_id == -1
        puts "Enter the number of the pet:"
        temp = gets.chomp.to_i
        count = person.belongings.fetch(:pets).length
        next if (temp.is_a? Numeric) == false
        next if (temp > count || temp < 1)
        animal_id = temp
        next
      else
        puts 'Pet:'.colorize(:color => :black, :background => :light_white)
        puts "Pet #{animal_id}" + "\n\n"
      end

      delete_pet(person_id - 1, animal_id - 1)
      char = STDIN.getch
      return
    end
  end

  def format_people
    # How many chars comprise the longest combo of name and surname
    longest = 0
    people.each do |person|
      contact = "#{person.identity.name} #{person.identity.surname}"
      longest = contact.length if contact.length > longest
    end
    # Make a list like: ["John Doe  @  [0.5, 1.5]"]
    formatted = []
    people.each do |person|
      contact = "#{person.identity.name} #{person.identity.surname}"
      if contact.length < longest
        diff = longest - contact.length
        diff.times do
          contact << " "
        end
      end
      contact << "  @   #{person.location.to_s}"
      formatted << contact
    end

    return formatted
  end

  def format_neighborhoods
    formatted = []
    hoods.each do |hood|
      formatted << hood.name
    end
    return formatted
  end

  def format_pets
    formatted = {} # key - person's index
    count = 1

    people.each_with_index do |person, person_id|
      if person.pets?
        names = [] #     ["Pet 1",   "Pet 2"]
        locations = [] # ["[0, 0]",  "[1, 1]"],
        distances = [] # [54 metres, 38 metres]

        owned_pets = person.belongings.fetch(:pets)
        owned_pets.each do |pet|
          names << "Pet #{count}"
          locations << pet.location.to_s
          distances << "#{person.location.calculate_distance(pet.location)} metres"
          count += 1
        end
        formatted[person_id] = {
          :names => names,
          :locations => locations, 
          :distances => distances
        }
      end
    end
    return formatted
  end

  def create_person(person)
    people << person
    persistance.store_data(map)
  end

  def update_person(index, location)
    person = people[index]
    person.change_location(location)
    persistance.store_data(map)
  end

  def delete_pet(person_id, pet_id)
    person = people[person_id]
    pets = person.belongings.fetch(:pets)
    pet = pets[pet_id]
    pets.delete(pet)
    persistance.store_data(map)
  end

  def change_choice(key_pressed, choice, choices_count)
    if key_pressed == KEYS[:UP]
      choice = choice - 1;
      choice = choices_count - 1 if choice < 0
    end

    if key_pressed == KEYS[:DOWN]
      choice = choice + 1;
      choice = 0 if choice > choices_count - 1
    end

    return choice
  end
end

KEYS = {
  :UP => "8",
  :OK => "6",
  :DOWN => "2",
  :CANCEL => "4" 
}

ui = UI.new
ui.show_main_menu
