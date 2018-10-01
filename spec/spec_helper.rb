# spec/spec_helper.rb

require 'simplecov'
SimpleCov.start do
  add_filter '.bundle/'
  add_filter 'UI.rb'
end

require 'ambulance'
require 'ambulance_repository'
require 'brigade'
require 'brigade_repository'
require 'city'
require 'drone'
require 'drone_repository'
require 'map'
require 'neighborhood'
require 'neighborhood_repository'
require 'notification'
require 'person'
require 'person_repository'
require 'police'
require 'police_repository'
require 'phone'
require 'location'
require 'vehicle'
require 'pet'
