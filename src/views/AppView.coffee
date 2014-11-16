class window.AppView extends Backbone.View
  template: _.template '
    <div class="score-card-container">
    </div>
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="dealer-hand-container"></div>
      <div><img src="img/card-back.png"/></div>
    <div class="player-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.game.player.hit()
    'click .stand-button': ->
      @model.game.player.stand()
      @model.game.dealer.playDealer()

  initialize: ->
    @render()

  render: ->
    @$el.addClass('errything')
    @$el.children().detach()
    @$el.html @template
    @gameFlowView = new GameFlowView(model: @model.game)
    @$('.dealer-hand-container').html new HandView(collection: @model.game.dealer).el
    @$('.player-hand-container').html new HandView(collection: @model.game.player).el
    @$('.score-card-container').html @gameFlowView.el

