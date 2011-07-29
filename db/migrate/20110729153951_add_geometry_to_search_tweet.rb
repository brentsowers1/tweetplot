class AddGeometryToSearchTweet < ActiveRecord::Migration
  def self.up
    add_column :search_tweets, :location, :point, :srid => 4326
  end

  def self.down
    drop_column :search_tweets, :location
  end
end
