class window.GameFlowView extends Backbone.View
  className: 'game-flow'

  template: _.template '
    <div>
      <table class="score-card-container">
        <tr><td>Player Wins</td><td class="player-score"><%=playerHands%></td></tr>
        <tr><td>Dealer Wins</td><td class="dealer-score"><%=dealerHands%></td></tr>
      </table>
      <h1><%=winner%></h1>
    </div>
  '

  initialize: ->
    console.log('game is flowy')
    @render()
    @model.on('change:winner', @render, @)

  render: ->
    defaults =
      playerHands: @model.get 'playerHands'
      dealerHands: @model.get 'dealerHands'
      winner: if (winner = @model.get('winner')) then winner + ' wins!' else ' '
    @$el.html(@template(
      defaults
    ))


