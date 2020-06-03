class Contact < ApplicationRecord

  def friendly_updated_at
    updated_at.strftime("%-d %B %Y %-l:%M%P")
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def japanese_phone_number
    "+81 #{phone_number}"
  end

end
