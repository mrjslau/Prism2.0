# spec/spec_helper.rb

require 'simplecov'
SimpleCov.start do
  add_filter '.bundle/'
  add_filter 'UI.rb'
end

require 'ambulance'
require 'brigade'
require 'building'
require 'city'
require 'drone'
require 'gate_barrier'
require 'identity'
require 'intersection'
require 'location'
require 'map'
require 'neighborhood'
require 'notification'
require 'person'
require 'police'
require 'phone'
require 'pet'
require 'traffic_light'
require 'user'
require 'vehicle'
require 'persistance'
