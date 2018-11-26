# Identity model, it has personal code as primary key
class Identity < ApplicationRecord
  self.primary_key = 'personal_code'
  has_one :residence
  has_many :criminal_records
  belongs_to :person

  def name
    full_name.split[0]
  end

  def surname
    full_name.split[1]
  end

  def add_criminal_record(criminal_record)
    criminal_records << criminal_record
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

end
