class RenameResponseColumn < ActiveRecord::Migration
  def change
    rename_column :inquiries, :response, :reply
  end
end
