require File.dirname(__FILE__) + '/../test_helper'
require 'notice_controller'

# Re-raise errors caught by the controller.
class NoticeController; def rescue_action(e) raise e end; end

class NoticeControllerTest < Test::Unit::TestCase
  def setup
    @controller = NoticeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
