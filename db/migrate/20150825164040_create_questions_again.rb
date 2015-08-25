class CreateQuestionsAgain < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.column :query, :string
      t.timestamps
    end
  end
end
