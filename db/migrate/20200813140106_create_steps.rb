class CreateSteps < ActiveRecord::Migration[6.0]
  def change
    create_table :steps do |t|
      t.string :title
      t.date :day_recorded

      t.timestamps
    end
  end
end
