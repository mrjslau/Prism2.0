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

# Command line UI file
# @persistance = Persistance.new('saved_data.yml')
# map = @persistance.fetch_data

class UI
    attr_reader :map
    def initialize
        persistance = Persistance.new('saved_data.yml')
        @map = persistance.fetch_data
    end

    # -------------------------------------------------
    # -------------------- DISPLAY --------------------
    # -------------------------------------------------

    def display_team_logo
        clear_console

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

        puts "\n"\
        " ____  _       _       []  _ _                       _     _                       \n"\
        "/ ___|| |_ ___| |__    __ (_|_)_ __ ___   ___    ___(_)___| |_ ___ _ __ ___   __ _ \n"\
        "\\___ \\| __/ _ \\ '_ \\ / _ \\| | | '_ ` _ \\ / _ \\  / __| / __| __/ _ \\ '_ ` _ \\ / _` |\n"\
        " ___) | ||  __/ |_) |  __/| | | | | | | | (_) | \\__ \\ \\__ \\ ||  __/ | | | | | (_| |\n"\
        "|____/ \\__\\___|_.__/ \\___|/ |_|_| |_| |_|\\___/  |___/_|___/\\__\\___|_| |_| |_|\\__,_|\n"\
        "                        |__/                                                       \n".light_yellow
    end

    def display_message(text, textColor = nil, backgroundColor = nil)
        if (textColor && backgroundColor)
            puts text.colorize(:color => textColor, :background => backgroundColor)
        elsif (textColor)
            puts text.colorize(:color => textColor)
        else
            puts text
        end
    end

    def display_options(heading, options, activeChoice)
        display_message(heading, :light_yellow)
        options.each_with_index do |value, index|
            if index == activeChoice
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

    # -------------------------------------------------
    # --------------------- MENUS ---------------------
    # -------------------------------------------------

    def show_main_menu
        heading = 'Choose what to observe:'
        choices = [
            'Neighborhoods',
            'People',
            'Pets',
            'Phones',
            'Exit'
        ]
        activeChoice = 0
        while (true)
            clear_console
            display_team_logo
            display_options(heading, choices, activeChoice)
            char = STDIN.getch

            if char == KEYS[:UP]
                activeChoice = activeChoice - 1;
                activeChoice = choices.count - 1 if activeChoice < 0
            end

            if char == KEYS[:DOWN]
                activeChoice = activeChoice + 1;
                activeChoice = 0 if activeChoice > choices.count - 1
            end

            if char == KEYS[:OK]
                show_neighborhood_actions() if activeChoice == 0
                show_person_actions() if activeChoice == 1
                return if activeChoice == 4
            end

            if char == KEYS[:CANCEL]
                return
            end
        end
    end
    
    def show_neighborhood_actions
        neighborhoods = format_neighborhoods()
        item_heading = 'Currently observed neighborhoods:'
        main_heading = ''
        choices = ['Back']
        activeChoice = 0
        while (true)
            clear_console
            display_team_logo
            display_static_list(item_heading, neighborhoods)
            display_options(main_heading, choices, activeChoice)
            char = STDIN.getch

            if char == KEYS[:UP]
                activeChoice = activeChoice - 1;
                activeChoice = choices.count - 1 if activeChoice < 0
            end

            if char == KEYS[:DOWN]
                activeChoice = activeChoice + 1;
                activeChoice = 0 if activeChoice > choices.count - 1
            end

            if char == KEYS[:OK]
                return if activeChoice == 0
            end

            if char == KEYS[:CANCEL]
                return if activeChoice == 0
            end
        end
    end

    def show_person_actions
        formatted = format_people()

        item_heading = 'Currently observed people:'
        main_heading = ''
        choices = ['Back']
        activeChoice = 0
        while (true)
            clear_console
            display_team_logo
            display_static_list(item_heading, formatted)
            display_options(main_heading, choices, activeChoice)
            char = STDIN.getch

            if char == KEYS[:UP]
                activeChoice = activeChoice - 1;
                activeChoice = choices.count - 1 if activeChoice < 0
            end

            if char == KEYS[:DOWN]
                activeChoice = activeChoice + 1;
                activeChoice = 0 if activeChoice > choices.count - 1
            end

            if char == KEYS[:OK]
                return if activeChoice == 0
            end

            if char == KEYS[:CANCEL]
                return if activeChoice == 0
            end
        end
    end

    # -------------------------------------------------
    # -------------------- HELPERS --------------------
    # -------------------------------------------------
    
    def format_people()
        people = map.residents

        # How many chars comprise the longest combo of name and surname
        longest = 0
        people.each do |p|
            contact = "#{p.identity.name} #{p.identity.surname}"
            longest = contact.length if contact.length > longest
        end

        # Make a list like: ["John Doe  @  [0.5, 1.5]"]
        formatted = []
        people.each do |p|
            contact = "#{p.identity.name} #{p.identity.surname}"
            if contact.length < longest
                diff = longest - contact.length
                diff.times do
                    contact << " "
                end
                contact << "  @   #{p.location.to_s}"
                formatted << contact
            end
        end

        return formatted
    end

    def format_neighborhoods()
        hoods = map.cities[0].neighborhoods
        formatted = []
        hoods.each do |h|
            formatted << h.name
        end
        return formatted
    end
    
end

KEYS = {
    :UP => "8",
    :OK => "6",
    :DOWN => "2",
    :CANCEL => "4" 
}

ui = UI.new
ui.display_team_logo
ui.show_main_menu

# action = 1
# while action != 0
#   puts "\n Choose your next action:"
#   puts '1 - neighborhoods, 2 - people, 3 - pets, 4 - phones, 0 - exit'
#   action = gets.chomp

#   case action

#   # NEIGHBORHOOD ACTIONS  
#   when '1'
#     @map.cities[0].neighborhoods.each do |n|
#       puts "\t" + n.name
#     end

#   # PERSON ACTIONS  
#   when '2'
#     paction = 1
#     @map.residents.each do |n|
#       puts "\t" + n.identity.name + ' ' + n.identity.surname + ' , location: ' + n.location.to_s
#     end
#     while paction != 0
#       puts "\n \t Choose your next action:"
#       puts "\t 1 - change location, 2 - add phone, 3 - remove phone, 4 - check if there are any phones nearby, 5 - does person have any phones?, 6 - add pet, 7 - remove pets, 8 - does person have any pet? 9 - person's status, 10 - list all residents, 0 - go back"
#       paction = gets.chomp

#       case paction
#       when '1'
#         puts "\n \t \t Enter person's first name"
#         name = gets.chomp
#         puts "\n \t \t Enter new latitude"
#         lat = gets.chomp.to_f
#         puts "\n \t \t Enter new longitude"
#         lon = gets.chomp.to_f
#         @map.residents.each do |n|
#           if n.identity.name.casecmp?(name)
#             n.change_location(Location.new(lat, lon))
#             break
#           end
#         end
#       when '2'
#         puts "\n \t \t Enter person's first name"
#         name = gets.chomp
#         puts "\n \t \t Enter latitude for a new phone"
#         lat = gets.chomp.to_f
#         puts "\n \t \t Enter longitude for a new phone"
#         lon = gets.chomp.to_f
#         @map.residents.each do |n|
#           if n.identity.name.casecmp?(name)
#             n.add_phone(Location.new(lat, lon))
#             break
#           end
#         end
#       when '3'
#         puts "\n \t \t Enter person's first name"
#         name = gets.chomp
#         @map.residents.each do |n|
#           if n.identity.name.casecmp?(name)
#             n.remove_phones
#             puts "\n \t \t \t " + n.identity.name + "'s phones removed. \n"
#           end
#         end
#       when '4'
#         puts "\n \t \t Enter person's first name"
#         name = gets.chomp
#         @map.residents.each do |n|
#           if n.identity.name.casecmp?(name)
#             if n.near_any_phone?
#               puts "\n \t \t \t There are phones nearby " + n.identity.name + " at distances:"
#               n.belongings.fetch(:phones).each do |p|
#                 puts "\t \t \t " + p.location.calculate_distance(n.location).to_s + 'meters.'
#               end
#               puts "\n"
#             else
#               puts "\n \t \t \t There are no phones nearny " + n.identity.name + ". \n"
#             end
#           end
#         end
#       when '5'
#         puts "\n \t \t Enter person's first name"
#         name = gets.chomp
#         @map.residents.each do |n|
#           if n.identity.name.casecmp?(name)
#             if n.phones?
#               puts "\n \t \t \t " + n.identity.name + " have phones at locations:"
#               n.belongings.fetch(:phones).each do |p|
#                 puts "\t \t \t " + p.location.to_s
#               end
#               puts "\n"
#             else
#               puts "\n \t \t \t " + n.identity.name + " doesn't have any phones. \n"
#             end
#           end
#         end
#       when '6'
#         puts "\n \t \t Enter person's first name"
#         name = gets.chomp
#         puts "\n \t \t Enter latitude for a new pet"
#         lat = gets.chomp.to_f
#         puts "\n \t \t Enter longitude for a new pet"
#         lon = gets.chomp.to_f
#         @map.residents.each do |n|
#           if n.identity.name.casecmp?(name)
#             n.add_pet(Location.new(lat, lon))
#             break
#           end
#         end
#       when '7'
#         puts "\n \t \t Enter person's first name"
#         name = gets.chomp
#         @map.residents.each do |n|
#           if n.identity.name.casecmp?(name)
#             n.remove_pets
#             puts "\n \t \t \t " + n.identity.name + "'s pets removed. \n"
#           end
#         end
#       when '8'
#         puts "\n \t \t Enter person's first name"
#         name = gets.chomp
#         @map.residents.each do |n|
#           if n.identity.name.casecmp?(name)
#             if n.pets?
#               puts "\n \t \t \t " + n.identity.name + " have pets at locations:"
#               n.belongings.fetch(:pets).each do |p|
#                 puts "\t \t \t " + p.location.to_s
#               end
#               puts "\n"
#             else
#               puts "\n \t \t \t " + n.identity.name + " doesn't have any pets. \n"
#             end
#           end
#         end
#       when '9'
#         puts "\n \t \t Enter person's first name"
#         name = gets.chomp
#         @map.residents.each do |n|
#           if n.identity.name.casecmp?(name)
#             puts "\n \t \t \t " + n.identity.name + ' is ' + n.status + "\n"
#           end
#         end
#       when '10'
#         @map.residents.each do |n|
#           puts "\t" + n.identity.name + ' ' + n.identity.surname + ' , location: ' + n.location.to_s
#         end
#       when '0'
#         break
#       end
#     end

#   # EXIT  
#   when '0'
#     @persistance.store_data(@map)
#     puts 'Goodbye!'
#     return
#   end
# end
