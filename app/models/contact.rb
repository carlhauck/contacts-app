class Contact < ApplicationRecord

  belongs_to :user
  has_many :contact_groups
  has_many :groups, through: :contact_groups

  validates :first_name, length: { minimum: 1 }, format: { with: /\A[a-zA-Z]+\z/,
    message: "First name can only contain letters. Sorry, Elon and Grimes." }
  validates :last_name, length: { minimum: 1 }, format: { with: /\A[a-zA-Z]+\z/,
    message: "Last name can only contain letters." }
  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }

  def friendly_updated_at
    updated_at.strftime("%-d %B %Y %-l:%M%P")
  end

  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end

  def japanese_phone_number
    "+81 #{phone_number}"
  end

end
