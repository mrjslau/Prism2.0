# lib/identity.rb

# Identity class represents identity of a Person
# It contains
class Identity
  attr_reader :name, :surname, :personal_code, :residence

  def initialize(name, surname, sex, date)
    @name = name
    @surname = surname
    @personal_code = personal_code_gen(sex, date)
    @residence = nil
  end

  def add_residence(building)
    @residence = building
  end

  def remove_residence
    @residence = nil
  end

  private

  def personal_code_gen(sex, date)
    # generates 13 digit number which represents person id
    # 1st number defines persons sex
    # 2-7th numbers represents persons age
    code = (sex.casecmp('male') ? 3 : 4).to_s + (date.tr('-./', '')[2, 7])
    idx_last = fetch_last_code_idx(code)
    code = (idx_last.nil? ? new_combo(code) : old_combo(idx_last))
    code.to_s
  end

  def fetch_last_code_idx(code)
    Map.instance.residents.rindex do |person|
      person.identity.personal_code.start_with?(code)
    end
  end

  def old_combo(idx)
    Map.instance.residents.fetch(idx).identity.personal_code.to_i + 1
  end

  def new_combo(code)
    (code.to_i * 10 + 2) * 10_000 + 1
  end
end
