class AddParserIdToPaste < ActiveRecord::Migration
  def self.up
    add_column :pastes, :parser_id, :integer
  end

  def self.down
    remove_column :pastes, :parser_id
  end
end
