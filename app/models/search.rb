require 'twitterscour'

class Search < ActiveRecord::Base
  has_many :search_tweets

  def do_search(num_pages=10)
    tweets = TwitterScour.search_term(self.term, num_pages)
    pages_retrieved = tweets.length / 15
    self.last_queried = Time.now
    self.pages_retrieved += pages_retrieved
    self.save
    sts = []
    tweets.each do |t|
      # Hack, a check if we already have the tweet should be done in TwitterScour, need
      # to add that.
      unless SearchTweet.find_by_text_and_author_name(t.text, t.author_name)
        st = SearchTweet.new(:search => self, :text => t.text, :author_name => t.author_name,
                             :author_pic => t.author_pic, :timestamp => t.time)
        if t.location
          st.location = Point.from_x_y(t.location.center[0], t.location.center[1], 4326)
        end
        st.save
        sts << st
      end
    end
    sts
  end
end
