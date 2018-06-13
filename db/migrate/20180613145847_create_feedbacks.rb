class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
        t.string :name
        t.string :email
        t.string :feedback
        t.timestamps null: false
    end
  end
end
