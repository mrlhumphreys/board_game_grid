require 'board_game_grid/point'

module BoardGameGrid

  # = Square
  #
  # A Square on a board
  class Square

    # New objects can be instantiated by passing in a hash with
    #
    # @param [Fixnum] id
    #   the unique identifier of the square.
    #
    # @param [Fixnum] x
    #   the x co-ordinate of the square.
    #
    # @param [Fixnum] y
    #   the y co-ordinate of the square.
    #
    # @option [Hash,NilClass] piece
    #   The piece on the square, can be a hash or nil.
    #
    # ==== Example:
    #   # Instantiates a new Square
    #   JustCheckers::Square.new({
    #     id: 1,
    #     x: 1,
    #     y: 0,
    #     piece: { player_number: 1, king: false }
    #   })
    def initialize(id: , x: , y: , piece: nil)
      @id = id
      @x = x
      @y = y
      @piece = piece
    end

    # @return [Fixnum] the unique identifier of the square.
    attr_reader :id

    # @return [Fixnum] the x co-ordinate of the square.
    attr_reader :x

    # @return [Fixnum] the y co-ordinate of the square.
    attr_reader :y

    # @return [Hash,NilClass] The piece on the square if any.
    attr_accessor :piece

    # A serialized version of the square as a hash
    #
    # @return [Hash]
    def as_json
      { 
        id: id, 
        x: x, 
        y: y, 
        piece: piece && piece.as_json
      }
    end

    # checks if the square matches the attributes passed.
    #
    # @param [Symbol] attribute
    #   the square's attribute.
    #
    # @param [Object,Hash] value
    #   a value to match on. Can be a hash of attribute/value pairs for deep matching
    #
    # ==== Example:
    #   # Check if square has a piece owned by player 1
    #   square.attribute_match?(:piece, player_number: 1)
    def attribute_match?(attribute, value)
      hash_obj_matcher = lambda do |obj, k, v|
        value = obj.send(k)
        if v.is_a?(Hash) && !value.nil?
          v.all? { |k2,v2| hash_obj_matcher.call(value, k2, v2) }
        elsif v.is_a?(Array) && !value.is_a?(Array)
          v.include?(value)
        elsif v.is_a?(Proc)
          v.call(value)
        else
          value == v
        end
      end

      hash_obj_matcher.call(self, attribute, value)
    end

    # Is the square occupied by a piece?
    #
    # @return [Boolean]
    def occupied?
      !!piece
    end

    # Is the square unoccupied by a piece?
    #
    # @return [Boolean]
    def unoccupied?
      !piece
    end

    # Is the square occupied by the specified player?
    #
    # @return [Boolean]
    def occupied_by_player?(player_number)
      piece && piece.player_number == player_number
    end

    # Is the square occupied by the specified player?
    #
    # @return [Boolean]
    def occupied_by_opponent?(player_number)
      piece && piece.player_number != player_number
    end

    # Is the square the same as another one?
    #
    # @return [Boolean]
    def ==(other)
      self.id == other.id
    end

    # A point object with the square's co-ordinates.
    #
    # @return [Point]
    def point
      Point.new(x, y)
    end

  end
end
