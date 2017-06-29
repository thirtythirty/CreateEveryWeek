class CreateContests < ActiveRecord::Migration[5.1]
  def change
    create_table :contests do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
