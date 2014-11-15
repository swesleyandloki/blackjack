
class window.Game extends Backbone.Model
  initialize: ()->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    @deck = @get 'deck'
    @dealer = @get 'dealerHand'
    @player = @get 'playerHand'

    @dealer.on('handsUp', @compare, @)
    @player.on('bust', @handOver, @)

    @on('handOver', @delayNewGame, @)

  compare: ()->
    console.log('im comparing')
    if (@dealer.isBust())
      alert('player wins')
      winner = 'player'
    else
      playerScore = @getScore(@player)
      dealerScore = @getScore(@dealer)
      if playerScore <= dealerScore
        alert('dealer wins')
      else
        alert('player wins')
        winner = 'player'
    @handOver(winner)

    # trigger 'game over, please redeal'
  handOver: (winner='dealer') ->
    @trigger('handOver', winner)

  getScore: (player)->
    playerScores = player.scores()
    if playerScores[1] > 21 then playerScores[0] else playerScores[1]

  newGame: () ->
    @player.reset(@deck.subsequentPlayerDeal())
    @dealer.reset(@deck.subsequentDealerDeal())
    @player.newHand()
    # @deck.faceUp()

  delayNewGame: () ->
    setTimeout(@newGame.bind(@), 3000)
