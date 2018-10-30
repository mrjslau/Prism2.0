# lib/map.rb

# Map class is a singleton and represents the main object
# with which the user will interact.
class Map
  attr_reader :notifications, :active_neighborhoods, :cities, :residents

  def initialize
    @notifications = []
    @active_neighborhoods = []
    @cities = []
    @residents = []
  end

  def self.instance
    @instance ||= new
  end

  private_class_method :new

  def select_neighborhood(neighborhood)
    !neighborhood.instance_of?(Neighborhood) ||
      active_neighborhoods << neighborhood
  end

  def notify_abnormal_person(person)
    notifications << Notification.new(person.identity.status_change_msg)
  end

  def personal_code_gen(sex, date)
    # generates 13 digit number which represents person id
    # 1st number defines persons sex
    # 2-7th numbers represents persons age
    code = String(sex.eql?('female') ? 4 : 3) + (date.tr('-./', '')[2..7])
    idx_last = fetch_last_code_idx(code) || true
    (
    if idx_last.instance_of?(TrueClass)
      (Integer(code) * 10_000)
    else
      old_combo(idx_last)
    end).to_s
  end

  def fetch_last_code_idx(code)
    residents.rindex do |person|
      person.identity.personal_code.start_with?(code)
    end
  end

  def old_combo(idx)
    Integer(residents.fetch(idx).identity.personal_code) + 1
  end
end
