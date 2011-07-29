class AddPostGis < ActiveRecord::Migration
  def self.up
    #execute "CREATE LANGUAGE plpgsql;"
    #`psql tweetplot_development -U postgres -h localhost -f /usr/share/postgresql/8.4/contrib/postgis.sql`
    #`psql tweetplot_development -U postgres -h localhost -f /usr/share/postgresql/8.4/contrib/spatial_ref_sys.sql`
  end

  def self.down
  end
end
