class CreateHealthChecks < ActiveRecord::Migration[8.1]
  def change
    create_table :health_checks do |t|
      t.references :api, null: false, foreign_key: true
      t.string :status
      t.float :response_time
      t.integer :status_code
      t.datetime :checked_at

      t.timestamps
    end
  end
end
