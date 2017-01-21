class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :amandments, :type, :category
  end
end
