# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  defaults:
    playerHands: 0
    dealerHands: 0

  initialize: ->
    @set 'game', game = new Game()
    @game = @get 'game'
