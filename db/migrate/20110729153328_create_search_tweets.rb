class CreateSearchTweets < ActiveRecord::Migration
  def self.up
    create_table :search_tweets do |t|
      t.integer :search_id
      t.string :text
      t.string :author_name
      t.string :author_pic
      t.time :timestamp

      t.timestamps
    end
  end

  def self.down
    drop_table :search_tweets
  end
end
