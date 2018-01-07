# BoardGameGrid

Data structure and logic for a board game grid. Provides classes that help interpret and operation on the state of a grid of squares with pieces on them.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'board_game_grid'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install board_game_grid

## Usage

The primary class is the square set, which can be initialised from an array of hashes:

```ruby
  square_set = BoardGameGrid::SquareSet.new(squares: [
    {id: 1, x: 2, y: 3, piece: nil},
    {id: 2, x: 4, y: 6, piece: {player_number: 1} }
  ])
```

or an array of squares:

```ruby
  square_set = BoardGameGrid::SquareSet.new(squares: [
    BoardGameGrid::Square.new({id: 1, x: 2, y: 3, piece: nil}),
    BoardGameGrid::Square.new({id: 2, x: 4, y: 6, piece: {player_number: 1}) }
  ])
```

A square set has some enumerable functionality and common enumerable methods can be called on it (e.g. `map`, `all?`, `include?`, `size`, `+`, `-`)

Most methods that would return an array of squares will return a square set object.

Querying methods such as `orthogonal` and `diagonal`, which returns a square set containing squares orthogonal or diagonal to an origin square are available.

Other querying methods include the `where` method which takes a hash of attribute/values to filter down the set.

```ruby
  square_set.where(x: 1, y: 2, piece: {player_number: 1})
```

More details are available in the documentation on rubydoc.info


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/board_game_grid. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the BoardGameGrid project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/board_game_grid/blob/master/CODE_OF_CONDUCT.md).
