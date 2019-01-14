class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.datetime :limit, null: false, default: -> {'NOW()'}
      t.integer :status,  null: false, default: 0
      t.timestamps
    end
  end
end
