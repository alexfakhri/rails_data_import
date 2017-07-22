class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :epoch_time_value
      t.string :validity
      t.string :choice

      t.timestamps
    end
  end
end
