require 'minitest/spec'
require 'minitest/autorun'
require 'board_game_grid/vector'
require 'board_game_grid/point'

describe BoardGameGrid::Vector do
  describe 'direction' do
    it 'must return the direction of the vector' do
      origin = BoardGameGrid::Point.new(0,0)
      destination = BoardGameGrid::Point.new(5,-5)
      vector = BoardGameGrid::Vector.new(origin, destination)
      direction = vector.direction

      assert_equal(1, direction.x)
      assert_equal(-1, direction.y)
    end
  end

  describe 'magnitude' do
    it 'must return the magnitude of the vector' do
      origin = BoardGameGrid::Point.new(0,0)
      destination = BoardGameGrid::Point.new(5,-5)
      vector = BoardGameGrid::Vector.new(origin, destination)

      assert_equal(5, vector.magnitude)
    end
  end

  describe 'orthogonal?' do
    it 'must return true if the points share the same x or y co-ordinate' do
      origin = BoardGameGrid::Point.new(5,0)
      destination = BoardGameGrid::Point.new(5,-5)
      vector = BoardGameGrid::Vector.new(origin, destination)

      assert(vector.orthogonal?)
    end

    it 'must return false if the points do not share the same x or y co-ordinate' do
      origin = BoardGameGrid::Point.new(0,0)
      destination = BoardGameGrid::Point.new(5,-5)
      vector = BoardGameGrid::Vector.new(origin, destination)

      refute(vector.orthogonal?)
    end
  end

  describe 'diagonal?' do
    it 'must return true if the absolute difference in x and y are the same' do
      origin = BoardGameGrid::Point.new(0,0)
      destination = BoardGameGrid::Point.new(5,-5)
      vector = BoardGameGrid::Vector.new(origin, destination)

      assert(vector.diagonal?)
    end

    it 'must return false if the absolute difference in x and y are different' do
      origin = BoardGameGrid::Point.new(5,0)
      destination = BoardGameGrid::Point.new(5,-5)
      vector = BoardGameGrid::Vector.new(origin, destination)

      refute(vector.diagonal?)
    end
  end

  describe 'orthogonal_or_diagonal?' do
    it 'must return true if the vector is orthogonal' do
      origin = BoardGameGrid::Point.new(5,0)
      destination = BoardGameGrid::Point.new(5,-5)
      vector = BoardGameGrid::Vector.new(origin, destination)

      assert(vector.orthogonal_or_diagonal?)
    end

    it 'must return true if the vector is diagonal' do
      origin = BoardGameGrid::Point.new(0,0)
      destination = BoardGameGrid::Point.new(5,-5)
      vector = BoardGameGrid::Vector.new(origin, destination)

      assert(vector.orthogonal_or_diagonal?)
    end

    it 'must return false if the vector is not orthogonal or diagonal' do
      origin = BoardGameGrid::Point.new(0,0)
      destination = BoardGameGrid::Point.new(1, 2)
      vector = BoardGameGrid::Vector.new(origin, destination)

      refute(vector.orthogonal_or_diagonal?)
    end
  end

  describe 'not_orthogonal_or_diagonal?' do
    it 'must return true if the vector is not orthogonal or diagonal' do
      origin = BoardGameGrid::Point.new(0,0)
      destination = BoardGameGrid::Point.new(1, 2)
      vector = BoardGameGrid::Vector.new(origin, destination)

      assert(vector.not_orthogonal_or_diagonal?)
    end

    it 'must return false if the vector is orthogonal' do
      origin = BoardGameGrid::Point.new(5,0)
      destination = BoardGameGrid::Point.new(5,-5)
      vector = BoardGameGrid::Vector.new(origin, destination)

      refute(vector.not_orthogonal_or_diagonal?)
    end

    it 'must return false if the vector is diagonal' do
      origin = BoardGameGrid::Point.new(0,0)
      destination = BoardGameGrid::Point.new(5,-5)
      vector = BoardGameGrid::Vector.new(origin, destination)

      refute(vector.not_orthogonal_or_diagonal?)
    end
  end

  describe '#dx' do
    it 'must return the distance on the x axis' do
      origin = BoardGameGrid::Point.new(3,3)
      destination = BoardGameGrid::Point.new(5,-5)
      vector = BoardGameGrid::Vector.new(origin, destination)

      assert_equal(vector.dx, 2)
    end
  end

  describe '#dy' do
    it 'must return the distance on the y axis' do
      origin = BoardGameGrid::Point.new(3,3)
      destination = BoardGameGrid::Point.new(5,-5)
      vector = BoardGameGrid::Vector.new(origin, destination)

      assert_equal(vector.dy, -8)
    end
  end
end
