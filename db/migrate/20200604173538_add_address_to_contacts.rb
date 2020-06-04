class AddAddressToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :address, :string
  end
end
