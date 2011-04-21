class AddResponseIdToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :response_id, :int
  end

  def self.down
    remove_column :posts, :response_id
  end
end
