class RemoveUserIdColumnFromContacts < ActiveRecord::Migration[6.0]
  def change
    remove_column :contacts, :user_id, :string
  end
end
