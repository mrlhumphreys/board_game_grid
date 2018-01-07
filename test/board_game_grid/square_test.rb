require 'minitest/spec'
require 'minitest/autorun'
require 'board_game_grid/square'

describe BoardGameGrid::Square do
  describe 'attribute_match?' do
    it 'must return true if attributes match' do
      square = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: nil)

      assert square.attribute_match?(:x, 2)
    end

    it 'must return false if attributes do not match' do
      square = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: nil)

      refute square.attribute_match?(:x, 4)
    end

    it 'must return true if nested attributes match' do
      piece = Struct.new(:player_number).new(4)
      square = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: piece)

      assert square.attribute_match?(:piece, player_number: 4)
    end

    it 'must return false if nested attributes do not match' do
      piece = Struct.new(:player_number).new(4)
      square = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: piece)

      refute square.attribute_match?(:piece, player_number: 6)
    end
  end

  describe 'occupied?' do
    it 'must return true if piece is present' do
      piece = {}
      square = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: piece)

      assert square.occupied?
    end

    it 'must return false if piece is not present' do
      piece = nil
      square = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: piece)

      refute square.occupied?
    end
  end

  describe 'unoccupied?' do
    it 'must return true if piece is not present' do
      piece = nil
      square = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: piece)

      assert square.unoccupied?
    end

    it 'must return false if piece is present' do
      piece = {}
      square = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: piece)

      refute square.unoccupied?
    end
  end

  describe 'comparison' do
    it 'must return true if they have the same id' do
      a = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: nil)
      b = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: nil)

      assert_equal(a, b)
    end

    it 'must return false if they have different ids' do
      a = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: nil)
      b = BoardGameGrid::Square.new(id: 2, x: 3, y: 4, piece: nil)

      refute_equal(a, b)
    end
  end

  describe 'point' do
    it 'must return a point with the same x and y co-ordinates' do
      x = 2
      y = 3
      square = BoardGameGrid::Square.new(id: 1, x: x, y: y, piece: nil)
      point = square.point

      assert_equal(x, point.x)
      assert_equal(y, point.y)
    end
  end

  describe 'as_json' do
    it 'must return the square as a hash representation' do
      square = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: nil)
      json = {id: 1, x: 2, y: 3, piece: nil}


      assert_equal(json, square.as_json)
    end
  end
end