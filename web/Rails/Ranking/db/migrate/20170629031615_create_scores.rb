class CreateScores < ActiveRecord::Migration[5.1]
  def change
    create_table :scores do |t|
      t.float :point
      t.references :user, foreign_key: true
      t.references :contest, foreign_key: true

      t.timestamps
    end
  end
end
