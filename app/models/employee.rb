class Employee < ApplicationRecord
  attr_accessor :editable

  belongs_to :country
  belongs_to :department

  validates :first_name, :last_name, :department_id, :country_id, presence: true
  validates :phone_number, presence: true, uniqueness: true, format: { with: /\A\d{10}\z/, message: "should be 10 digits" }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :search, ->(query) {
    if query.present?
      left_joins(:department)
        .where("employees.id LIKE ? OR first_name LIKE ? OR last_name LIKE ? OR departments.name LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
    else
      all
    end
  }
end
