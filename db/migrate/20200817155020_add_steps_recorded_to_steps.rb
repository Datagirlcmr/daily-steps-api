class AddStepsRecordedToSteps < ActiveRecord::Migration[6.0]
  def change
    add_column :steps, :steps_recorded, :integer
  end
end
