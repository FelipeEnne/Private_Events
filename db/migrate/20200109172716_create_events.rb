class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.text :address
      t.date :start_date
      t.time :start_time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
