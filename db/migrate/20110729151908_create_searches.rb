class CreateSearches < ActiveRecord::Migration
  def self.up
    create_table :searches do |t|
      t.text :term
      t.time :last_queried
      t.integer :pages_retrieved, :null => false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :searches
  end
end
