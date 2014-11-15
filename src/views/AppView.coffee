class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.game.player.hit()
    'click .stand-button': ->
      @model.game.player.stand()
      @model.game.dealer.playDealer()

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.game.player).el
    @$('.dealer-hand-container').html new HandView(collection: @model.game.dealer).el

