require 'forwardable'
require 'board_game_grid/square'
require 'board_game_grid/vector'

module BoardGameGrid

  # = Square Set
  #
  # A collection of Squares with useful filtering functions
  class SquareSet
    extend Forwardable

    # New objects can be instantiated by passing in a hash with squares.
    # They can be square objects or hashes.
    #
    # @param [Array<Square,Hash>] squares
    #   An array of squares, each with x and y co-ordinates and a piece.
    #
    # ==== Example:
    #   # Instantiates a new Square Set
    #   BoardGameGrid::SquareSet.new({
    #     squares: [
    #       { x: 1, y: 0, piece: { player_number: 1, king: false }}
    #     ]
    #   })
    def initialize(squares: [])
      @squares = if squares.all? { |s| s.instance_of?(Hash) }
        squares.map { |s| BoardGameGrid::Square.new(s) }
      elsif squares.all? { |s| s.instance_of?(BoardGameGrid::Square) }
        squares
      else
        raise ArgumentError, "all squares must have the same class"
      end
    end

    # @return [Array<Square>] The squares in the set.
    attr_reader :squares

    def_delegator :squares, :find
    def_delegator :squares, :first
    def_delegator :squares, :size
    def_delegator :squares, :any?
    def_delegator :squares, :all?
    def_delegator :squares, :none?
    def_delegator :squares, :include?
    def_delegator :squares, :map
    def_delegator :squares, :each
    def_delegator :squares, :empty?

    # Concat two SquareSets together
    #
    # @param [SquareSet] other
    #   the second SquareSet
    #
    # @return [SquareSet]
    # ==== Example:
    #   # Concat two SquareSets together
    #   square_set + other
    def +(other)
      _squares = squares + other.squares

      self.class.new(squares: _squares)
    end

    # Remove squares from one SquareSet from another
    #
    # @param [SquareSet] other
    #   the second SquareSet
    #
    # @return [SquareSet]
    # ==== Example:
    #   # Remove squares from one SquareSet
    #   square_set - other
    def -(other)
      _squares = squares - other.squares

      self.class.new(squares: _squares)
    end

    # Push a Square onto a SquareSet
    #
    # @param [Square] square
    #   the square being pushed on
    #
    # @return [SquareSet]
    # ==== Example:
    #   # Push a Square onto a SquareSet
    #   square_set << square
    def <<(square)
      _squares = squares << square

      self.class.new(squares: _squares)
    end

    # Find the intersection of Squares between sets
    #
    # @param [SquareSet] other
    #   the second SquareSet
    #
    # @return [SquareSet]
    # ==== Example:
    #   # Find the intersection of Squares
    #   square_set & other
    def &(other)
      select { |square| other.include?(square) }
    end

    # Filter the squares with a block and behaves like Enumerable#select.
    # It returns a SquareSet with the filtered squares.
    #
    # @return [SquareSet]
    def select(&block)
      _squares = squares.select(&block)

      self.class.new(squares: _squares)
    end

    # Filter the squares with a hash of attribute and matching values.
    #
    # @param [Hash] hash
    #   attributes to query for.
    #
    # @return [SquareSet]
    #
    # ==== Example:
    #   # Find all squares where piece is nil
    #   square_set.where(piece: nil)
    def where(hash)
      res = hash.inject(squares) do |memo, (attribute, value)|
        memo.select { |square| square.attribute_match?(attribute, value) }
      end
      self.class.new(squares: res)
    end

    # Find the square with the matching unique identifier
    #
    # @param [Fixnum] id
    #   the unique identifier.
    #
    # @return [Square]
    # ==== Example:
    #   # Find the square with id 4
    #   square_set.find_by_id(4)
    def find_by_id(id)
      select { |s| s.id == id }.first
    end

    # Find the square with the matching x and y co-ordinates
    #
    # @param [Fixnum] x
    #   the x co-ordinate.
    #
    # @param [Fixnum] y
    #   the y co-ordinate.
    #
    # @return [Square]
    # ==== Example:
    #   # Find the square at 4,2
    #   square_set.find_by_x_and_y(4, 2)
    def find_by_x_and_y(x, y)
      select { |s| s.x == x && s.y == y }.first
    end

    # Find all squares within distance of square
    #
    # @param [Square] square
    #   the originating square
    #
    # @param [Fixnum] distance
    #   the specified distance from the square
    #
    # @return [SquareSet]
    # ==== Example:
    #   # Get all squares within 2 squares of square_a
    #   square_set.in_range(square_a, 2)
    def in_range(square, distance)
      select { |s| Vector.new(square, s).magnitude <= distance }
    end

    # Find all squares at distance of square
    #
    # @param [Square] square
    #   the originating square
    #
    # @param [Fixnum] distance
    #   the specified distance from the square
    #
    # @return [SquareSet]
    # ==== Example:
    #   # Get all squares at 2 squares from square_a
    #   square_set.at_range(square_a, 2)
    def at_range(square, distance)
      select { |s| Vector.new(square, s).magnitude == distance }
    end

    # Find all squares orthogonal from square
    #
    # @param [Square] square
    #   the originating square
    #
    # @return [SquareSet]
    # ==== Example:
    #   # Get all squares orthogonal from square_a
    #   square_set.orthogonal(square_a)
    def orthogonal(square)
      select { |s| Vector.new(square, s).orthogonal? }
    end

    # Find all squares diagonal from square
    #
    # @param [Square] square
    #   the originating square
    #
    # @return [SquareSet]
    # ==== Example:
    #   # Get all squares diagonal from square_a
    #   square_set.diagonal(square_a)
    def diagonal(square)
      select { |s| Vector.new(square, s).diagonal? }
    end

    # Find all squares orthogonal or diagonal from square
    #
    # @param [Square] square
    #   the originating square
    #
    # @return [SquareSet]
    # ==== Example:
    #   # Get all squares orthogonal or diagonal from square_a
    #   square_set.orthogonal_or_diagonal(square_a)
    def orthogonal_or_diagonal(square)
      select { |s| Vector.new(square, s).orthogonal_or_diagonal? }
    end

    # Find all squares not orthogonal or diagonal from square
    #
    # @param [Square] square
    #   the originating square
    #
    # @return [SquareSet]
    # ==== Example:
    #   # Get all squares not orthogonal or diagonal from square_a
    #   square_set.not_orthogonal_or_diagonal(square_a)
    def not_orthogonal_or_diagonal(square)
      select { |s| Vector.new(square, s).not_orthogonal_or_diagonal? }
    end

    # Find all squares without pieces on them.
    #
    # @return [SquareSet]
    def unoccupied
      select(&:unoccupied?)
    end

    # Returns destination from the origin that have a clear path
    #
    # @param [Square] origin
    #   the originating square.
    #
    # @param [SquareSet] square_set
    #   the board position.
    #
    # @return [SquareSet]
    def unblocked(origin, square_set)
      select { |destination| square_set.between(origin, destination).all?(&:unoccupied?) }
    end

    # Returns squares between a and b.
    # Only squares that are in the same diagonal will return squares.
    #
    # @param [Square] a
    #   a square.
    #
    # @param [Square] b
    #   another square.
    #
    # @return [SquareSet]
    #
    # ==== Example:
    #   # Get all squares between square_a and square_b
    #   square_set.between(square_a, square_b)
    def between(a, b)
      vector = Vector.new(a, b)

      if vector.diagonal? || vector.orthogonal?
        point_counter = a.point
        direction = vector.direction
        _squares = []

        while point_counter != b.point
          point_counter = point_counter + direction
          square = find_by_x_and_y(point_counter.x, point_counter.y)
          if square && square.point != b.point
            _squares.push(square)
          end
        end
      else
        _squares = []
      end

      self.class.new(squares: _squares)
    end

    # serializes the squares as a hash
    #
    # @return [Hash]
    def as_json
      squares.map(&:as_json)
    end
  end
end