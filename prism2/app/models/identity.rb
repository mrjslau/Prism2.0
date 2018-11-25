# Identity model, it has personal code as primary key
class Identity < ApplicationRecord
  has_many :criminal_records
  belongs_to :person

  def name
    full_name.fetch(:name)
  end

  def surname
    full_name.fetch(:surname)
  end

  def add_criminal_record(offence, neighborhood)
    criminal_records << { offence_level: offence,
                          neighborhood: neighborhood }
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

end
