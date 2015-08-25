class RenameResponsesColumn < ActiveRecord::Migration
  def change
    rename_column :inquiries, :responses, :response
  end
end
