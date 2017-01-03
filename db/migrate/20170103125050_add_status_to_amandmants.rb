class AddStatusToAmandmants < ActiveRecord::Migration
  def change
    add_column :amandments, :status, :string
  end
end
