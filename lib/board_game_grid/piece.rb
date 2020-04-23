module BoardGameGrid

  # = Piece
  #
  # A piece that can move on a board
  class Piece
    # The forwards direciton of the piece for each player
    FORWARDS_DIRECTION = { 1 => -1, 2 => 1 }

    def initialize(id: , player_number: , type: nil)
      @id = id
      @player_number = player_number
    end

    # @return [Fixnum] the identifier of the piece.
    attr_reader :id

    # @return [Fixnum] the owner of the piece.
    attr_reader :player_number

    # The opposing player number
    #
    # @return [Fixnum]
    def opponent
      player_number == 1 ? 2 : 1
    end

    # The stringified identifier of the piece type.
    #
    # @return [Fixnum]
    def type
      self.class.to_s.split('::').last.downcase
    end

    # Can the piece move from a square, to a square, given the game state?
    # 
    # @param [Square] from
    #   the origin square.
    #
    # @param [Square] to
    #   the destination square.
    #
    # @param [GameState] game_state
    #   the current game state.
    #
    # @return [Boolean]
    def can_move?(from, to, game_state)
      destinations(from, game_state).include?(to) 
    end

    # All the squares that the piece can move to and/or capture.
    #
    # @param [Square] square 
    #   the origin square.
    #
    # @param [GameState] game_state
    #   the current game state.
    #
    # @return [SquareSet]
    def destinations(square, game_state)
      []
    end

    # All the squares that the piece can move to.
    #
    # @param [Square] square
    #   the origin square.
    #
    # @param [GameState] game_state
    #   the current game state.
    #
    # @return [SquareSet]
    def move_squares(square, game_state)
      destinations(square, game_state)
    end

    # All the squares that the piece can capture.
    #
    # @param [Square] square
    #   the origin square.
    #
    # @param [GameState] game_state
    #   the current game state.
    #
    # @return [SquareSet]
    def capture_squares(squares, game_state)
      destinations(squares, game_state)
    end

    # All the squares that the piece could potentially capture. (i.e. if a piece was there)
    #
    # @param [Square] square
    #   the origin square.
    #
    # @param [GameState] game_state
    #   the current game state.
    #
    # @return [SquareSet]
    def potential_capture_squares(square, game_state)
      capture_squares(square, game_state)
    end

    # returns a serialized piece as a hash
    #
    # @return [Hash]
    def as_json
      {
        id: id,
        player_number: player_number,
        type: type
      }
    end

    # returns the direction the piece moves
    #
    # player 1 moves up (-1)
    # player 2 moves down (1)
    #
    # @return [Fixnum]
    def forwards_direction
      FORWARDS_DIRECTION[player_number]
    end
  end
end
