class CreateParsers < ActiveRecord::Migration
  def self.up
    create_table :parsers do |t|
      t.string :display_name
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :parsers
  end
end
