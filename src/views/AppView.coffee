class window.AppView extends Backbone.View
  template: _.template '
    <table class="score-card-container">
      <tr><td>Player Wins</td><td class="player-score"><%=playerHands%></td></tr>
      <tr><td>Dealer Wins</td><td class="dealer-score"><%=dealerHands%></td></tr>
    </table>
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
    @model.on('change:playerHands change:dealerHands', @updateScores, @)

  render: ->
    @$el.children().detach()
    @$el.html @template
      playerHands: @model.get('playerHands')
      dealerHands: @model.get('dealerHands')
    @$('.player-hand-container').html new HandView(collection: @model.game.player).el
    @$('.dealer-hand-container').html new HandView(collection: @model.game.dealer).el

  updateScores: ->
    @$('.dealer-score').text(@model.get('dealerHands'))
    @$('.player-score').text(@model.get('playerHands'))
    return
