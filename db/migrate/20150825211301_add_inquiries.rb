class AddInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.column :responses, :string
      t.column :question_id, :integer
      t.timestamps
    end
  end
end
