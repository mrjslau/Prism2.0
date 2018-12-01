# Identity model, it has personal code as primary key
class Identity < ApplicationRecord
  self.primary_key = :personal_code
  has_one :residence
  has_many :criminal_records
  belongs_to :person
  validates :full_name, presence: true
  validates :gender, presence: true, inclusion: %w[male female]
  validates :person, presence: true, uniqueness: true
  validates :birthday, presence: true
  before_create :init_personal_code

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

  private

  def init_personal_code
    self.personal_code = generate_personal_code
  end

  def generate_personal_code
    from = (gen_no * 1_000_000 + birth_code) * 10_000
    to = from + 10_000
    last_similar_id = Identity.where(personal_code: from..to)
                              .last.personal_code || false
    new_code = last_similar_id || from
    new_code + 1
  end

  def birth_code
    birthday.strftime('%Y%m%d')[2..7].to_i
  end

  def gen_no
    gender == 'male' ? 3 : 4
  end

  # def last_id(from, to)
  #  last_similar_id = Identity.where(personal_code: from..to)
  #                            .last.personal_code
  #  last_similar_id ? last_similar_id.personal_code : false
  # end
end
