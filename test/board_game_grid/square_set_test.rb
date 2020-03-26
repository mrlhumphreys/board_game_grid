require 'minitest/spec'
require 'minitest/autorun'
require 'board_game_grid/square_set'

describe BoardGameGrid::SquareSet do
  describe 'initialize' do
    it 'must initialize squares from hash' do
      square_set = BoardGameGrid::SquareSet.new(squares: [ {id: 1, x: 2, y: 3} ])
      square = square_set.first

      assert_equal(1, square.id)
      assert_equal(2, square.x)
      assert_equal(3, square.y)
    end

    it 'must initialize squares from square' do
      square_set = BoardGameGrid::SquareSet.new(squares: [ BoardGameGrid::Square.new(id: 1, x: 2, y: 3) ])
      square = square_set.first

      assert_equal(1, square.id)
      assert_equal(2, square.x)
      assert_equal(3, square.y)
    end

    it 'must raise error if there is a mix of arguments' do
      assert_raises(ArgumentError) {
        BoardGameGrid::SquareSet.new(squares: [ BoardGameGrid::Square.new(id: 1, x: 2, y: 3), 'abc' ])
      }
    end

    it 'must raise error if there are no hash or squares' do
      assert_raises(ArgumentError) {
        BoardGameGrid::SquareSet.new(squares: [ 1, 'abc' ])
      }
    end
  end

  describe 'concat' do
    it 'must combine the squares from both sets' do
      square_a = BoardGameGrid::Square.new(id: 1, x: 2, y: 3)
      square_b = BoardGameGrid::Square.new(id: 2, x: 3, y: 4)

      square_set_a = BoardGameGrid::SquareSet.new(squares: [ square_a ])
      square_set_b = BoardGameGrid::SquareSet.new(squares: [ square_b ])

      result = square_set_a + square_set_b

      assert_includes(result, square_a)
      assert_includes(result, square_b)
    end
  end

  describe 'difference' do
    it 'must return a set with squares from the first and not from the second' do
      square_a = BoardGameGrid::Square.new(id: 1, x: 2, y: 3)
      square_b = BoardGameGrid::Square.new(id: 2, x: 3, y: 4)

      square_set_a = BoardGameGrid::SquareSet.new(squares: [ square_a, square_b])
      square_set_b = BoardGameGrid::SquareSet.new(squares: [ square_b ])

      result = square_set_a - square_set_b

      assert_includes(result, square_a)
      refute_includes(result, square_b)
    end
  end

  describe 'push' do
    it 'must add square to the set' do
      square_a = BoardGameGrid::Square.new(id: 1, x: 2, y: 3)
      square_b = BoardGameGrid::Square.new(id: 2, x: 3, y: 4)

      square_set = BoardGameGrid::SquareSet.new(squares: [ square_a ])

      result = square_set << square_b

      assert_includes(result, square_a)
      assert_includes(result, square_b)
    end
  end

  describe 'intersection' do
    it 'must return a set with squares common between the sets' do
      square_a = BoardGameGrid::Square.new(id: 1, x: 2, y: 3)
      square_b = BoardGameGrid::Square.new(id: 2, x: 3, y: 4)
      square_c = BoardGameGrid::Square.new(id: 3, x: 4, y: 5)

      square_set_a = BoardGameGrid::SquareSet.new(squares: [ square_a, square_b ])
      square_set_b = BoardGameGrid::SquareSet.new(squares: [ square_b, square_c ])

      result = square_set_a & square_set_b

      refute_includes(result, square_a)
      assert_includes(result, square_b)
      refute_includes(result, square_c)
    end
  end

  describe 'union' do
    it 'must return a set of unique squares that are in both sets' do
      square_a = BoardGameGrid::Square.new(id: 1, x: 2, y: 3)
      square_b = BoardGameGrid::Square.new(id: 2, x: 3, y: 4)
      square_c = BoardGameGrid::Square.new(id: 3, x: 4, y: 5)

      square_set_a = BoardGameGrid::SquareSet.new(squares: [ square_a, square_b ])
      square_set_b = BoardGameGrid::SquareSet.new(squares: [ square_b, square_c ])

      result = square_set_a | square_set_b

      assert_includes(result, square_a)
      assert_includes(result, square_b)
      assert_includes(result, square_c)
      assert_equal(result.size, 3)
    end
  end

  describe 'select' do
    it 'must return a set with squares matching the block conditions' do
      square_a = BoardGameGrid::Square.new(id: 1, x: 2, y: 3)
      square_b = BoardGameGrid::Square.new(id: 2, x: 3, y: 4)

      square_set = BoardGameGrid::SquareSet.new(squares: [ square_a, square_b ])

      result = square_set.select { |s| s.id % 2 == 0 }

      assert_includes(result, square_b)
      refute_includes(result, square_a)
    end
  end

  describe 'uniq' do
    it 'must return a set with uniq squares' do
      square_a = BoardGameGrid::Square.new(id: 1, x: 2, y: 3)
      square_b = BoardGameGrid::Square.new(id: 2, x: 3, y: 4)

      square_set = BoardGameGrid::SquareSet.new(squares: [ square_a, square_a, square_b ])

      result = square_set.uniq

      assert_equal(result.size, 2)
    end
  end

  describe 'where' do
    it 'must return a set with squares matching the attributes' do
      square_a = BoardGameGrid::Square.new(id: 1, x: 2, y: 3)
      square_b = BoardGameGrid::Square.new(id: 2, x: 3, y: 4)

      square_set = BoardGameGrid::SquareSet.new(squares: [ square_a, square_b ])

      result = square_set.where(x: 2)

      assert_includes(result, square_a)
    end
  end

  describe 'find_by_id' do
    it 'must return a square with the matching id' do
      square_a = BoardGameGrid::Square.new(id: 1, x: 2, y: 3)
      square_b = BoardGameGrid::Square.new(id: 2, x: 3, y: 4)

      square_set = BoardGameGrid::SquareSet.new(squares: [ square_a, square_b ])

      result = square_set.find_by_id(1)

      assert_equal(square_a, result)
    end
  end

  describe 'find_by_x_and_y' do
    it 'must return a square with the matching co-ordinates' do
      square_a = BoardGameGrid::Square.new(id: 1, x: 2, y: 3)
      square_b = BoardGameGrid::Square.new(id: 2, x: 3, y: 4)

      square_set = BoardGameGrid::SquareSet.new(squares: [ square_a, square_b ])

      result = square_set.find_by_x_and_y(3,4)

      assert_equal(square_b, result)
    end
  end

  describe 'in_range' do
    it 'must return squares within the specified range of origin' do
      square_a = BoardGameGrid::Square.new(id: 1, x: 0, y: 0)
      square_b = BoardGameGrid::Square.new(id: 2, x: 0, y: 1)
      square_c = BoardGameGrid::Square.new(id: 3, x: 0, y: 2)
      square_d = BoardGameGrid::Square.new(id: 4, x: 0, y: 3)

      square_set = BoardGameGrid::SquareSet.new(squares: [ square_a, square_b, square_c, square_d ])

      result = square_set.in_range(square_a, 2)

      assert_includes(result, square_b)
      assert_includes(result, square_c)
      refute_includes(result, square_d)
    end
  end

  describe 'at_range' do
    it 'must return squares at the specified range of origin' do
      square_a = BoardGameGrid::Square.new(id: 1, x: 0, y: 0)
      square_b = BoardGameGrid::Square.new(id: 2, x: 0, y: 1)
      square_c = BoardGameGrid::Square.new(id: 3, x: 0, y: 2)
      square_d = BoardGameGrid::Square.new(id: 4, x: 0, y: 3)

      square_set = BoardGameGrid::SquareSet.new(squares: [ square_a, square_b, square_c, square_d ])

      result = square_set.at_range(square_a, 2)

      refute_includes(result, square_b)
      assert_includes(result, square_c)
      refute_includes(result, square_d)
    end
  end

  describe 'ranks_away' do
    it 'must return squares a certain number of ranks away' do
      square_a = BoardGameGrid::Square.new(id: 1, x: 0, y: 0)
      square_b = BoardGameGrid::Square.new(id: 2, x: 0, y: 1)
      square_c = BoardGameGrid::Square.new(id: 3, x: 0, y: 2)
      square_d = BoardGameGrid::Square.new(id: 4, x: 0, y: 3)

      square_set = BoardGameGrid::SquareSet.new(squares: [ square_a, square_b, square_c, square_d ])

      result = square_set.ranks_away(square_a, 2)

      refute_includes(result, square_b)
      assert_includes(result, square_c)
      refute_includes(result, square_d)
    end
  end

  describe 'files_away' do
    it 'must return squares a certain number of ranks away' do
      square_a = BoardGameGrid::Square.new(id: 1, x: 0, y: 0)
      square_b = BoardGameGrid::Square.new(id: 2, x: 1, y: 0)
      square_c = BoardGameGrid::Square.new(id: 3, x: 2, y: 0)
      square_d = BoardGameGrid::Square.new(id: 4, x: 3, y: 0)

      square_set = BoardGameGrid::SquareSet.new(squares: [ square_a, square_b, square_c, square_d ])

      result = square_set.files_away(square_a, 2)

      refute_includes(result, square_b)
      assert_includes(result, square_c)
      refute_includes(result, square_d)
    end
  end

  describe 'orthogonal' do
    it 'must return squares orthogonal to the origin' do
      origin = BoardGameGrid::Square.new(id: 1, x: 0, y: 0)
      orthogonal = BoardGameGrid::Square.new(id: 2, x: 0, y: 1)
      diagonal = BoardGameGrid::Square.new(id: 3, x: 1, y: 1)
      l_shape = BoardGameGrid::Square.new(id: 4, x: 1, y: 2)

      square_set = BoardGameGrid::SquareSet.new(squares: [ origin, orthogonal, diagonal, l_shape ])

      result = square_set.orthogonal(origin)

      assert_includes(result, orthogonal)
      refute_includes(result, diagonal)
      refute_includes(result, l_shape)
    end
  end

  describe 'diagonal' do
    it 'must return squares diagonal to the origin' do
      origin = BoardGameGrid::Square.new(id: 1, x: 0, y: 0)
      orthogonal = BoardGameGrid::Square.new(id: 2, x: 0, y: 1)
      diagonal = BoardGameGrid::Square.new(id: 3, x: 1, y: 1)
      l_shape = BoardGameGrid::Square.new(id: 4, x: 1, y: 2)

      square_set = BoardGameGrid::SquareSet.new(squares: [ origin, orthogonal, diagonal, l_shape ])

      result = square_set.diagonal(origin)

      refute_includes(result, orthogonal)
      assert_includes(result, diagonal)
      refute_includes(result, l_shape)
    end
  end

  describe 'orthogonal_or_diagonal' do
    it 'must return squares orthogonal or diagonal to the origin' do
      origin = BoardGameGrid::Square.new(id: 1, x: 0, y: 0)
      orthogonal = BoardGameGrid::Square.new(id: 2, x: 0, y: 1)
      diagonal = BoardGameGrid::Square.new(id: 3, x: 1, y: 1)
      l_shape = BoardGameGrid::Square.new(id: 4, x: 1, y: 2)

      square_set = BoardGameGrid::SquareSet.new(squares: [ origin, orthogonal, diagonal, l_shape ])

      result = square_set.orthogonal_or_diagonal(origin)

      assert_includes(result, orthogonal)
      assert_includes(result, diagonal)
      refute_includes(result, l_shape)
    end
  end

  describe 'not_orthogonal_or_diagonal' do
    it 'must return squares not orthogonal or diagonal to the origin' do
      origin = BoardGameGrid::Square.new(id: 1, x: 0, y: 0)
      orthogonal = BoardGameGrid::Square.new(id: 2, x: 0, y: 1)
      diagonal = BoardGameGrid::Square.new(id: 3, x: 1, y: 1)
      l_shape = BoardGameGrid::Square.new(id: 4, x: 1, y: 2)

      square_set = BoardGameGrid::SquareSet.new(squares: [ origin, orthogonal, diagonal, l_shape ])

      result = square_set.not_orthogonal_or_diagonal(origin)

      refute_includes(result, orthogonal)
      refute_includes(result, diagonal)
      assert_includes(result, l_shape)
    end
  end

  describe 'unoccupied' do
    it 'must return squares that are unoccupied' do
      occupied = BoardGameGrid::Square.new(id: 1, x: 0, y: 0, piece: { player_number: 1 })
      unoccupied = BoardGameGrid::Square.new(id: 2, x: 1, y: 1, piece: nil)

      square_set = BoardGameGrid::SquareSet.new(squares: [ occupied, unoccupied ])

      result = square_set.unoccupied

      assert_includes(result, unoccupied)
      refute_includes(result, occupied)
    end
  end

  describe 'unblocked' do
    it 'must return squares that are unblocked from the origin' do
      origin = BoardGameGrid::Square.new(id: 1, x: 0, y: 0, piece: { player_number: 1 })
      unblocked = BoardGameGrid::Square.new(id: 2, x: 0, y: 1, piece: nil)
      block = BoardGameGrid::Square.new(id: 3, x: 0, y: 2, piece: { player_number: 2 })
      beyond = BoardGameGrid::Square.new(id: 4, x: 0, y: 3, piece: nil)

      square_set = BoardGameGrid::SquareSet.new(squares: [ origin, unblocked, block, beyond ])

      result = square_set.unblocked(origin, square_set)

      assert_includes(result, unblocked)
      assert_includes(result, block)
      refute_includes(result, beyond)
    end
  end

  describe 'between' do
    it 'must return squares between the origin and destination' do
      origin = BoardGameGrid::Square.new(id: 1, x: 0, y: 0, piece: { player_number: 1 })
      between = BoardGameGrid::Square.new(id: 2, x: 0, y: 1, piece: nil)
      destination = BoardGameGrid::Square.new(id: 3, x: 0, y: 2, piece: { player_number: 2 })
      beyond = BoardGameGrid::Square.new(id: 4, x: 0, y: 3, piece: nil)

      square_set = BoardGameGrid::SquareSet.new(squares: [ origin, between, destination, beyond ])

      result = square_set.between(origin, destination)

      assert_includes(result, between)
      refute_includes(result, destination)
      refute_includes(result, beyond)
    end
  end

  describe 'as_json' do
    it 'must return an array of serialised squares' do
      square_a_args = {id: 1, x: 2, y: 3, piece: nil}
      square_a = BoardGameGrid::Square.new(**square_a_args)
      square_b_args = {id: 2, x: 3, y: 4, piece: nil}
      square_b = BoardGameGrid::Square.new(**square_b_args)

      square_set = BoardGameGrid::SquareSet.new(squares: [ square_a, square_b ])

      json = [square_a_args, square_b_args]

      assert_equal(json, square_set.as_json)
    end
  end
end
