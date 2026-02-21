# frozen_string_literal: true

require "test_helper"

class MygitTest < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::Mygit.const_defined?(:VERSION)
    end
  end

  # test "URL" do
  #   assert_equal("https://github.com/dvarrui/mygit", ::Mygit::URL)
  # end
end