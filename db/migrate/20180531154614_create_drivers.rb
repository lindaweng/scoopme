class CreateDrivers < ActiveRecord::Migration[5.2]
  def change
    create_table :drivers do |t|
        t.string :name
        t.string :age
        t.string :password
        t.string :address
        t.string :city
        t.string :state
        t.string :email
        t.string :phone
        t.string :plate
        t.string :car
        t.string :school
        t.string :riders, array: true, default: []
        t.timestamps null: false
    end
  end
end
