require 'minitest/spec'
require 'minitest/autorun'
require 'board_game_grid/square'
require 'board_game_grid/piece'

describe BoardGameGrid::Square do
  describe 'as_json' do
    describe 'with piece' do
      it 'serializes the square into a hash' do
        piece = BoardGameGrid::Piece.new(id: 1, player_number: 1, type: 'piece')
        square = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: piece)

        result = square.as_json
        expected = {
          id: 1,
          x: 2,
          y: 3, 
          piece: { id: 1, player_number: 1, type: 'piece' }
        }

        assert_equal(expected, result) 
      end
    end

    describe 'without piece' do
      it 'serializes the square into a hash' do
        square = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: nil)
        expected = {
          id: 1,
          x: 2,
          y: 3,
          piece: nil
        }

        result = square.as_json

        assert_equal(expected, result)
      end
    end
  end

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

    it 'must return true if attribute is in array of attributes' do
      piece = Struct.new(:player_number).new(4)
      square = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: piece)

      assert square.attribute_match?(:x, [1, 2, 3])
    end

    it 'must return false if attribute is not in array of attributes' do
      piece = Struct.new(:player_number).new(4)
      square = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: piece)

      refute square.attribute_match?(:x, [4, 5, 6])
    end

    it 'must return true if attribute matches proc' do
      piece = Struct.new(:player_number).new(4)
      square = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: piece)

      assert square.attribute_match?(:y, -> (y) { y >= 2 })
    end

    it 'must return false if attribute does not match proc' do
      piece = Struct.new(:player_number).new(4)
      square = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: piece)

      refute square.attribute_match?(:y, -> (y) { y <= 2 })
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

  describe 'occupied_by_player?' do
    describe 'when piece owner matches player number' do
      it 'must return true' do
        piece = BoardGameGrid::Piece.new(id: 1, player_number: 1, type: 'piece') 
        square = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: piece)

        assert square.occupied_by_player?(1)
      end
    end

    describe 'when piece owner does not match player number' do
      it 'must return false' do
        piece = BoardGameGrid::Piece.new(id: 1, player_number: 1, type: 'piece') 
        square = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: piece)

        refute square.occupied_by_player?(2)
      end
    end
  end

  describe 'occupied_by_opponent?' do
    describe 'when piece owner does not match player number' do
      it 'must return true' do
        piece = BoardGameGrid::Piece.new(id: 1, player_number: 2, type: 'piece') 
        square = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: piece)

        assert square.occupied_by_opponent?(1)
      end
    end

    describe 'when piece owner does match player number' do
      it 'must return false' do
        piece = BoardGameGrid::Piece.new(id: 1, player_number: 2, type: 'piece') 
        square = BoardGameGrid::Square.new(id: 1, x: 2, y: 3, piece: piece)

        refute square.occupied_by_opponent?(2)
      end
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
end
