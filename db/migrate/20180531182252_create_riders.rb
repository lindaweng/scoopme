class CreateRiders < ActiveRecord::Migration[5.2]
  def change
    create_table :riders do |t|
        t.string :name
        t.string :age
        t.string :password
        t.string :email
        t.string :phone
        t.string :school
        t.string :drivers, array: true, default: []
        t.timestamps null: false
    end
  end
end
