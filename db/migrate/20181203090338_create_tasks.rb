class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.date :limit, null: false, default: -> {'NOW()'}
      t.timestamps
    end
  end
end
