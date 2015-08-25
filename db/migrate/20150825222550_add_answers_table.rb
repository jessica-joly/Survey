class AddAnswersTable < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.column :user_id, :integer
      t.column :survey_id,:integer
      t.column :question_id, :integer
      t.column :reply_id, :integer
      t.timestamps
    end
  end
end
