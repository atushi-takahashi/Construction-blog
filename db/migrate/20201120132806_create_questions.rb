class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.integer :user_id, null: false
      t.integer :category_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.string :image_id
      t.string :status, null:false
      t.boolean :solution_flag, default: false
      t.boolean :delete_flag, default: false
      t.timestamps
    end
  end
end
