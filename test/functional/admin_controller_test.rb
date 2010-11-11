#---
# Excerpted from "Agile Web Development with Rails, 3rd Ed.",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails3 for more book information.
#---

require File.dirname(__FILE__) + '/../test_helper'
#require 'test_helper'
#require 'admin_controller'

class AdminControllerTest < ActionController::TestCase

  fixtures :users

  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  if false
    
    def test_index 
      get :index 
      assert_response :success 
    end
    
  end

  def test_index_without_user
    get :index
    assert_redirected_to :action => "login"
    assert_equal "Please log in", flash[:notice]
  end


  
  def test_index_with_user
    get :index, {}, { :user_id => users(:dave).id }
    assert_response :success
    assert_template "index"
  end

  def test_login
    dave = users(:dave)
    post :login, :name => dave.name, :password => 'admin'
    assert_redirected_to :action => "index"
    assert_equal dave.id, session[:user_id]
  end

  def test_bad_password
    dave = users(:dave)
    post :login, :name => dave.name, :password => 'wrong'
    assert_template "login"
  end
  
end

