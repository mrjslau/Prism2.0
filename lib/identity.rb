# lib/identity.rb

# Identity class represents identity of a Person
# It contains
class Identity
  attr_reader :full_name, :personal_code, :residence, :criminal_records

  def initialize(name, surname, sex, date)
    @full_name = { name: name, surname: surname }
    @personal_code = Map.instance.personal_code_gen(sex, date)
    @criminal_records = []
  end

  def name
    full_name.fetch(:name)
  end

  def surname
    full_name.fetch(:surname)
  end

  def add_criminal_record(offence, neighborhood)
    criminal_records << { offence_level: offence,
                          neighborhood: neighborhood }
    Map.instance.notify_abnormal_person(person) if criminal_records_no > 5
  end

  def criminal_records_no
    criminal_records.length
  end

  def criminal_status
    if criminal_records_no > 0
      if criminal_records_no > 5
        'dangerous'
      else
        'suspicious'
      end
    else
      'normal'
    end
  end

  def status_change_msg
    "#{name} #{surname}'s criminal status changed to: #{criminal_status}!"
  end

  def add_residence(building)
    @residence = building
  end

  def remove_residence
    remove_instance_variable(:@residence)
  end

  def person
    Map.instance.residents.find { |person| person.identity.equal?(self) }
  end
end
