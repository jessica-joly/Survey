class AddResponsesAgain < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.column :inquiry, :string
      t.column :question_id, :integer
      t.timestamps
    end
  end
end
