class CreateDetections < ActiveRecord::Migration[7.1]
  def change
    create_table :detections do |t|
      t.string :plague
      t.integer :severity

      t.timestamps
    end
  end
end
