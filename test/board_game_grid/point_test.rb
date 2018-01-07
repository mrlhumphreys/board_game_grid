require 'minitest/spec'
require 'minitest/autorun'
require 'board_game_grid/point'

describe BoardGameGrid::Point do
  describe 'adding two points' do
    it 'must sum the co-ordinates' do
      a = BoardGameGrid::Point.new(1,5)
      b = BoardGameGrid::Point.new(2,-7)

      sum = a + b

      assert_equal(3, sum.x)
      assert_equal(-2, sum.y)
    end
  end

  describe 'comparing two points' do
    it 'must return true when co-ordinates are equal' do
      a = BoardGameGrid::Point.new(1,3)
      b = BoardGameGrid::Point.new(1,3)

      assert_equal(a, b)
    end

    it 'must return false if the co-ordinates are not equal' do
      a = BoardGameGrid::Point.new(1,3)
      b = BoardGameGrid::Point.new(2,3)

      refute_equal(a, b)
    end
  end
end