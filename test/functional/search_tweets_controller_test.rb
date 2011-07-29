require 'test_helper'

class SearchTweetsControllerTest < ActionController::TestCase
  setup do
    @search_tweet = search_tweets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:search_tweets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create search_tweet" do
    assert_difference('SearchTweet.count') do
      post :create, :search_tweet => @search_tweet.attributes
    end

    assert_redirected_to search_tweet_path(assigns(:search_tweet))
  end

  test "should show search_tweet" do
    get :show, :id => @search_tweet.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @search_tweet.to_param
    assert_response :success
  end

  test "should update search_tweet" do
    put :update, :id => @search_tweet.to_param, :search_tweet => @search_tweet.attributes
    assert_redirected_to search_tweet_path(assigns(:search_tweet))
  end

  test "should destroy search_tweet" do
    assert_difference('SearchTweet.count', -1) do
      delete :destroy, :id => @search_tweet.to_param
    end

    assert_redirected_to search_tweets_path
  end
end
