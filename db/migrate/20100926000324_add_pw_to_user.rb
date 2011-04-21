class AddPwToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :pw, :string, :limit => 16
  end

  def self.down
    remove_column :users, :pw
  end
end
