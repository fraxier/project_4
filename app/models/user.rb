require 'pry'
class User < ApplicationRecord
  has_many :tickets
  has_many :events, through: :tickets

  with_options unless: :external_login? do |login|
    login.validates :password, length: { minimum: 8, maximum: 20 }
    login.validates :password, format: { with: /\A[\d\w]+\z/ }
  end

  validates :username, presence: true
  validates :email, presence: true

  def external_login?
    is_external_login
  end

  def field_has_error?(sym)
    if !self[sym].nil? && errors.messages[sym].empty?
      false
    else
      true
    end
  end
end
