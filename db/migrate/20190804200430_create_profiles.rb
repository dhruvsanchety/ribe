class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.attachment :avatar
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :age
      t.string :gender
      t.string :city
      t.string :collegeemail
      t.timestamps
    end
  end
end
