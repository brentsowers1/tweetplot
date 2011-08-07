class SearchesController < ApplicationController
  # GET /searches
  # GET /searches.xml
  def index
    @searches = Search.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @searches }
    end
  end

  # GET /searches/1
  # GET /searches/1.xml
  def show
    @search = Search.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @search }
    end
  end

  # GET /searches/new
  # GET /searches/new.xml
  def new
    @search = Search.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @search }
    end
  end

  # GET /searches/1/edit
  def edit
    @search = Search.find(params[:id])
  end

  # POST /searches
  # POST /searches.xml
  def create
    @search = Search.new(params[:search])

    respond_to do |format|
      if @search.save
        format.html { redirect_to(@search, :notice => 'Search was successfully created.') }
        format.xml  { render :xml => @search, :status => :created, :location => @search }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @search.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /searches/1
  # PUT /searches/1.xml
  def update
    @search = Search.find(params[:id])

    respond_to do |format|
      if @search.update_attributes(params[:search])
        format.html { redirect_to(@search, :notice => 'Search was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @search.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.xml
  def destroy
    @search = Search.find(params[:id])
    @search.destroy

    respond_to do |format|
      format.html { redirect_to(searches_url) }
      format.xml  { head :ok }
    end
  end

  def do_search
    @search = Search.find(params[:id])
    @tweets = @search.do_search
    @bound_tweets = []
    @tweets.each do |t|
      if t.within_bounds?(params[:neLat].to_f, params[:neLng].to_f, params[:swLat].to_f, params[:swLng].to_f)
        @bound_tweets << t
      end
    end
    render :json => @bound_tweets
  end

  def view_map
    @map = true
    @search = Search.find(params[:id])
    @last_tweet = @search.search_tweets.find(:last, :conditions => "location IS NOT NULL")
    if @last_tweet
      @center_lat = @last_tweet.location.y
      @center_lng = @last_tweet.location.x
    else
      @center_lat = 38.9
      @center_lng = -77.1
    end
  end

  def tweets
    @search = Search.find(params[:id])
    if params[:neLat]
      @tweets = @search.search_tweets.find_all(:conditions => ["location && ?",
        Polygon.from_coordiantes([[
          [params[:swLng].to_f, params[:swLat].to_f],
          [params[:swLng].to_f, params[:neLat].to_f],
          [params[:neLng].to_f, params[:neLat].to_f],
          [params[:neLng].to_f, params[:swLat].to_f],
          [params[:swLng].to_f, params[:swLat].to_f]
         ]], 4269)])
    else
      @tweets = @search.search_tweets.find(:all, :order => "id DESC", :limit => "100")
    end
    render :json => @tweets
  end
end
