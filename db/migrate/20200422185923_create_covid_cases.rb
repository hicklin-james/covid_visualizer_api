class CreateCovidCases < ActiveRecord::Migration[6.0]
  def change
    create_table :covid_cases do |t|
      t.integer :case_id, null: false
      t.date :date_last_updated, null: false
      t.date :date_created, null: false
      t.integer :gender, null: false
      t.integer :age_group, null: false
      t.integer :transmission_method, null: false
      t.integer :hospitalization_required, null: false
      t.integer :intensive_care_required, null: false

      t.timestamps
    end
  end
end
