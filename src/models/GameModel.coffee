
class window.Game extends Backbone.Model
  defaults:
    playerHands: 0
    dealerHands: 0

  initialize: ()->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'winner', ''

    @deck = @get 'deck'
    @dealer = @get 'dealerHand'
    @player = @get 'playerHand'

    @dealer.on('handsUp', @compare, @)
    @player.on('bust', @compare, @)

    @on('handOver', @delayNewGame, @)

  compare: ()->
    console.log('im comparing')
    if(@player.isBust())
      @set 'winner','dealer'
    if (@dealer.isBust())
      @set 'winner','player'
    else
      playerScore = @getScore(@player)
      dealerScore = @getScore(@dealer)
      if playerScore <= dealerScore
        @set 'winner','dealer'
      else
        @set 'winner','player'
    @handOver()

    # trigger 'game over, please redeal'
  handOver: () ->
    @trigger('handOver', @get 'winner')

  getScore: (player)->
    playerScores = player.scores()
    if playerScores[1] > 21 then playerScores[0] else playerScores[1]

  newGame: () ->
    @set 'winner', null
    @player.reset(@deck.subsequentPlayerDeal())
    @dealer.reset(@deck.subsequentDealerDeal())
    @player.newHand()
    # @deck.faceUp()

  delayNewGame: () ->
    @updateCount()
    setTimeout(@newGame.bind(@), 3000)


  updateCount: () ->
    winner = @get 'winner'
    @set (winner + 'Hands'), (@get(winner + 'Hands') + 1)

