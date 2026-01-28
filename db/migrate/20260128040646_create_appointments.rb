class CreateAppointments < ActiveRecord::Migration[8.0]
  def change
    create_table :appointments do |t|
      t.string :title
      t.datetime :scheduled_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
