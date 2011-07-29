class AddLatLngToSearchTweet < ActiveRecord::Migration
  def self.up
    add_column :search_tweets, :lat, :float
    add_column :search_tweets, :lng, :float
  end

  def self.down
  end
end
