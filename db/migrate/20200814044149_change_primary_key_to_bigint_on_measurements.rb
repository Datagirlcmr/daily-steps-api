class ChangePrimaryKeyToBigintOnMeasurements < ActiveRecord::Migration[6.0]
  def change
    change_column :measurements, :steps_recorded, :bigint
  end
end
