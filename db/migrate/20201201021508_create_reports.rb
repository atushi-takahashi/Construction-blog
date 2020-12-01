class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :question_id
      t.integer :category
      t.text :message
      t.timestamps
    end
  end
end
