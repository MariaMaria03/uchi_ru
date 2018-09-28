require 'test_helper'

class StaticPagesTest < ActionDispatch::IntegrationTest

  test "can see name title" do
    get root_path
    assert_select 'h3', 'UCHI.RU'
  end

  test "exist input on active users page" do
    get '/active_users_repos'
    assert_select 'input'
  end

  test "should have title" do
    get '/active_users_repos'
    assert_select 'title', 'Активные контрибьюторы репозитория'
  end

  test "success request contributors" do
    get root_path
    assert_response :success

    get "/active_users_repos",
         params: { repos_url: 'https://github.com/rubyzip/rubyzip' }
    assert_response :success
    assert_select 'table'
  end

  test "request contributors with empty results" do
    get root_path
    assert_response :success

    get "/active_users_repos",
        params: { repos_url: 'repository' }
    assert_response :success
    assert_select 'h4.results_not_found'
  end

  test "creating new repository" do
    assert_difference 'Repository.count', +1 do
      get "/active_users_repos", params: { repos_url: 'https://github.com/spree/spree' }
    end
  end

  test "not create new contributor" do
    assert_difference 'Contributor.count', 0 do
      get "/active_users_repos", params: { repos_url: '' }
    end
  end
end
