# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20181126173441) do

  create_table "ambulances", force: :cascade do |t|
    t.integer "map_id"
    t.integer "neighborhood_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["map_id"], name: "index_ambulances_on_map_id"
    t.index ["neighborhood_id"], name: "index_ambulances_on_neighborhood_id"
  end

  create_table "criminal_records", force: :cascade do |t|
    t.integer "police_station_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "identity_id"
    t.integer "neighborhood_id"
    t.integer "offence_level"
    t.index ["identity_id"], name: "index_criminal_records_on_identity_id"
    t.index ["neighborhood_id"], name: "index_criminal_records_on_neighborhood_id"
    t.index ["police_station_id"], name: "index_criminal_records_on_police_station_id"
  end

  create_table "drones", force: :cascade do |t|
    t.integer "map_id"
    t.integer "neighborhood_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["map_id"], name: "index_drones_on_map_id"
    t.index ["neighborhood_id"], name: "index_drones_on_neighborhood_id"
  end

  create_table "fire_brigades", force: :cascade do |t|
    t.integer "map_id"
    t.integer "neighborhood_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["map_id"], name: "index_fire_brigades_on_map_id"
    t.index ["neighborhood_id"], name: "index_fire_brigades_on_neighborhood_id"
  end

  create_table "gate_barriers", force: :cascade do |t|
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "identities", id: false, force: :cascade do |t|
    t.bigint "personal_code"
    t.string "full_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "person_id"
    t.integer "criminal_status"
    t.index ["person_id"], name: "index_identities_on_person_id"
  end

  create_table "intersections", force: :cascade do |t|
    t.string "name"
    t.integer "street_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "person_id"
    t.integer "phone_id"
    t.integer "pet_id"
    t.integer "vehicle_id"
    t.integer "gate_barrier_id"
    t.index ["gate_barrier_id"], name: "index_locations_on_gate_barrier_id"
    t.index ["person_id"], name: "index_locations_on_person_id"
    t.index ["pet_id"], name: "index_locations_on_pet_id"
    t.index ["phone_id"], name: "index_locations_on_phone_id"
    t.index ["vehicle_id"], name: "index_locations_on_vehicle_id"
  end

  create_table "maps", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "neighborhoods", force: :cascade do |t|
    t.string "name"
    t.float "temperature"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "map_id"
    t.text "active_objects"
    t.index ["map_id"], name: "index_neighborhoods_on_map_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.text "message"
    t.integer "map_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["map_id"], name: "index_notifications_on_map_id"
  end

  create_table "people", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "map_id"
    t.index ["map_id"], name: "index_people_on_map_id"
  end

  create_table "pets", force: :cascade do |t|
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_pets_on_person_id"
  end

  create_table "phones", force: :cascade do |t|
    t.boolean "turned_on"
    t.boolean "connected"
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_phones_on_person_id"
  end

  create_table "police_stations", force: :cascade do |t|
    t.integer "map_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["map_id"], name: "index_police_stations_on_map_id"
  end

  create_table "police_units", force: :cascade do |t|
    t.integer "map_id"
    t.integer "neighborhood_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["map_id"], name: "index_police_units_on_map_id"
    t.index ["neighborhood_id"], name: "index_police_units_on_neighborhood_id"
  end

  create_table "traffic_lights", force: :cascade do |t|
    t.integer "intersection_id"
    t.string "signal"
    t.boolean "blinking"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["intersection_id"], name: "index_traffic_lights_on_intersection_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "licence_number"
    t.integer "owner_id"
    t.integer "driver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "map_id"
    t.index ["driver_id"], name: "index_vehicles_on_driver_id"
    t.index ["map_id"], name: "index_vehicles_on_map_id"
    t.index ["owner_id"], name: "index_vehicles_on_owner_id"
  end

end
