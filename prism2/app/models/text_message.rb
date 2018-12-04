# Phone's text message model class
class TextMessage < ApplicationRecord
  belongs_to :author, class_name: 'Phone'
  belongs_to :recipient, class_name: 'Phone'
  attr_reader :text_message
end
