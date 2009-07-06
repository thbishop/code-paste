class AddNumOfLinesToPastes < ActiveRecord::Migration
  def self.up
    add_column :pastes, :number_of_lines, :integer
  end

  def self.down
    remove_column :pastes, :number_of_lines
  end
end
