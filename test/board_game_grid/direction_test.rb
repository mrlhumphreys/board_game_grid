require 'minitest/autorun'
require 'minitest/spec'
require 'board_game_grid/direction'

describe BoardGameGrid::Direction do
  describe 'initializing with dx and dy' do
    it 'must set x and y to be between -1 and 1' do
      direction = BoardGameGrid::Direction.new(5, -4)

      assert_equal(1, direction.x)
      assert_equal(-1, direction.y)
    end
  end

  describe 'comparing two directions' do
    it 'must return true if their x and y are the same' do
      a = BoardGameGrid::Direction.new(3, -4)
      b = BoardGameGrid::Direction.new(1, -3)

      assert_equal(a, b)
    end

    it 'must return false if their x and y are different' do
      a = BoardGameGrid::Direction.new(-3, -4)
      b = BoardGameGrid::Direction.new(1, -3)

      refute_equal(a, b)
    end
  end
end
