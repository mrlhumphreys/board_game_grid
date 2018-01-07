require 'board_game_grid/direction'

module BoardGameGrid

  # = Vector
  #
  # An element of Vector space
  class Vector

    # New objects can be instantiated by passing in a two points with x and y co-ordinates
    #
    # @param [Point] origin
    #   the start point.
    #
    # @param [Point] destination
    #   the end point.
    #
    # ==== Example:
    #   # Instantiates a new Vector
    #   BoardGameGrid::Vector.new(
    #     BoardGameGrid::Point.new(x: 1, y: 1),
    #     BoardGameGrid::Point.new(x: 3, y: 3)
    #   )
    def initialize(origin, destination)
      @origin, @destination = origin, destination
    end

    # @return [Object] the origin.
    attr_reader :origin

    # @return [Object] the destination.
    attr_reader :destination

    # The direction of the vector as a object
    #
    # @return [Direction]
    def direction
      Direction.new(dx, dy)
    end

    # The biggest difference between co-ordinates
    #
    # @return [Fixnum]
    def magnitude
      [dx.abs, dy.abs].max
    end

    # Is the vector orthogonal?
    #
    # @return [Boolean]
    def orthogonal?
      dx == 0 || dy == 0
    end

    # Is the vector diagonal?
    #
    # @return [Boolean]
    def diagonal?
      dx.abs == dy.abs
    end

    # Is the vector not orthogonal or diagonal?
    #
    # @return [Boolean]
    def not_orthogonal_or_diagonal?
      !(orthogonal? || diagonal?)
    end

    # Is the vector orthogonal or diagonal?
    #
    # @return [Boolean]
    def orthogonal_or_diagonal?
      orthogonal? || diagonal?
    end

    private

    def dx
      destination.x - origin.x
    end

    def dy
      destination.y - origin.y
    end
  end
end