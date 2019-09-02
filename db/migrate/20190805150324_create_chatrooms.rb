class CreateChatrooms < ActiveRecord::Migration[5.0]
  def change
    create_table :chatrooms do |t|
    
      t.string :title
      t.text :details
      t.string :gender
      t.string :collegestudent
      t.integer :minimumage
      t.integer :maximumage
      t.boolean :visible, :default => true
      t.timestamps
      t.string :city
    end
  end
end
