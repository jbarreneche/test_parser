require_relative 'test_helper'
require_relative '../life'

class TestSomething < MiniTest::Unit::TestCase
  include SomeSharedTest

  def test_foo
    life = Life.new
    assert life.alive?
  end

end