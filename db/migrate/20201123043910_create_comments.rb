class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :post_id
      t.integer :question_id
      t.text :message, null: false
      t.timestamps
    end
  end
end
