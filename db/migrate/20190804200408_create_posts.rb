class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
      t.text :details
      t.string :gender
      t.string :collegestudent
      t.integer :minimumage
      t.integer :maximumage
      t.timestamps
    end
  end
end
