require 'minitest/spec'
require 'minitest/autorun'
require 'board_game_grid/piece'

describe BoardGameGrid::Piece do
  describe '#opponent' do
    it 'returns 1 if player number is 2' do
      piece = BoardGameGrid::Piece.new(id: 1, player_number: 1)

      assert_equal(2, piece.opponent)
    end

    it 'returns 2 if player number is 1' do
      piece = BoardGameGrid::Piece.new(id: 1, player_number: 2)

      assert_equal(1, piece.opponent)
    end
  end

  describe '#type' do
    it 'returns the downcased classname' do
      class Unicorn < BoardGameGrid::Piece; end
      unicorn = Unicorn.new(id: 1, player_number: 1)

      assert_equal('unicorn', unicorn.type)
    end
  end

  describe '#can_move?' do
    class Unicorn < BoardGameGrid::Piece
      def destinations(_square, _game_state)
        BoardGameGrid::SquareSet.new(squares: [
          BoardGameGrid::Square.new(id: 1, x: 1, y: 1, piece: nil),
          BoardGameGrid::Square.new(id: 2, x: 1, y: 2, piece: nil),
        ])    
      end
    end

    it 'returns true if the to is in the destinations' do
      unicorn = Unicorn.new(id: 1, player_number: 1)
      from = BoardGameGrid::Square.new(id: 3, x: 1, y: 3, piece: nil)
      to = BoardGameGrid::Square.new(id: 1, x: 1, y: 1, piece: nil)
      game_state = {}

      assert unicorn.can_move?(from, to, game_state)
    end

    it 'returns false if the to is not in the destinations' do
      unicorn = Unicorn.new(id: 1, player_number: 1)
      from = BoardGameGrid::Square.new(id: 3, x: 1, y: 3, piece: nil)
      to = BoardGameGrid::Square.new(id: 4, x: 1, y: 4, piece: nil)
      game_state = {}

      refute unicorn.can_move?(from, to, game_state)
    end
  end

  describe '#destinations' do
    it 'returns an empty set by default' do
      piece = BoardGameGrid::Piece.new(id: 1, player_number: 1)
      square = BoardGameGrid::Square.new(id: 3, x: 1, y: 3, piece: nil)
      game_state = {}

      assert_empty piece.destinations(square, game_state)
    end
  end

  describe '#move_squares' do
    it 'should be the same as destinations' do
      piece = BoardGameGrid::Piece.new(id: 1, player_number: 1)
      square = BoardGameGrid::Square.new(id: 3, x: 1, y: 3, piece: nil)
      game_state = {}

      destinations = piece.destinations(square, game_state)
      move_squares = piece.move_squares(square, game_state)

      assert_equal destinations, move_squares
    end
  end

  describe '#capture_squares' do
    it 'should be the same as destinations' do
      piece = BoardGameGrid::Piece.new(id: 1, player_number: 1)
      square = BoardGameGrid::Square.new(id: 3, x: 1, y: 3, piece: nil)
      game_state = {}

      destinations = piece.destinations(square, game_state)
      capture_squares = piece.capture_squares(square, game_state)

      assert_equal destinations, capture_squares
    end
  end

  describe '#potential_capture_squares' do
    it 'should be the same as capture squares' do
      piece = BoardGameGrid::Piece.new(id: 1, player_number: 1)
      square = BoardGameGrid::Square.new(id: 3, x: 1, y: 3, piece: nil)
      game_state = {}

      capture_squares = piece.capture_squares(square, game_state)
      potential_capture_squares = piece.potential_capture_squares(square, game_state)

      assert_equal capture_squares, potential_capture_squares
    end
  end

  describe '#as_json' do
    it 'should return the piece as a hash' do
      piece = BoardGameGrid::Piece.new(id: 1, player_number: 1)
      expected = {
        id: 1,
        player_number: 1,
        type: 'piece'
      }

      assert_equal expected, piece.as_json
    end
  end

  describe '#forwards_direction' do
    it 'should return -1 if player is 1' do
      piece = BoardGameGrid::Piece.new(id: 1, player_number: 1)

      assert_equal(-1, piece.forwards_direction)
    end

    it 'should return 1 if player is 2' do
      piece = BoardGameGrid::Piece.new(id: 1, player_number: 2)

      assert_equal(1, piece.forwards_direction)
    end
  end
end
