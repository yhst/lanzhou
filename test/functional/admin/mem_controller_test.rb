require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/mem_controller'

# Re-raise errors caught by the controller.
class Admin::MemController; def rescue_action(e) raise e end; end

class Admin::MemControllerTest < Test::Unit::TestCase
  def setup
    @controller = Admin::MemController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
