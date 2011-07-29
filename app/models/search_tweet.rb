class SearchTweet < ActiveRecord::Base
  belongs_to :search

  def within_bounds?(ne_lat, ne_lng, sw_lat, sw_lng)
    if self.location
      lat = self.location.y
      lng = self.location.x
      (lat >= sw_lat && lat <= ne_lat && lng >= sw_lng && lng <= ne_lng)
    end
  end
end
