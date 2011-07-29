class SearchTweetsController < ApplicationController
  # GET /search_tweets
  # GET /search_tweets.xml
  def index
    @search_tweets = SearchTweet.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @search_tweets }
    end
  end

  # GET /search_tweets/1
  # GET /search_tweets/1.xml
  def show
    @search_tweet = SearchTweet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @search_tweet }
    end
  end

  # GET /search_tweets/new
  # GET /search_tweets/new.xml
  def new
    @search_tweet = SearchTweet.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @search_tweet }
    end
  end

  # GET /search_tweets/1/edit
  def edit
    @search_tweet = SearchTweet.find(params[:id])
  end

  # POST /search_tweets
  # POST /search_tweets.xml
  def create
    @search_tweet = SearchTweet.new(params[:search_tweet])

    respond_to do |format|
      if @search_tweet.save
        format.html { redirect_to(@search_tweet, :notice => 'Search tweet was successfully created.') }
        format.xml  { render :xml => @search_tweet, :status => :created, :location => @search_tweet }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @search_tweet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /search_tweets/1
  # PUT /search_tweets/1.xml
  def update
    @search_tweet = SearchTweet.find(params[:id])

    respond_to do |format|
      if @search_tweet.update_attributes(params[:search_tweet])
        format.html { redirect_to(@search_tweet, :notice => 'Search tweet was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @search_tweet.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /search_tweets/1
  # DELETE /search_tweets/1.xml
  def destroy
    @search_tweet = SearchTweet.find(params[:id])
    @search_tweet.destroy

    respond_to do |format|
      format.html { redirect_to(search_tweets_url) }
      format.xml  { head :ok }
    end
  end
end
