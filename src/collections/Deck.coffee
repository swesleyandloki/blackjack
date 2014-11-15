class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> new Hand @subsequentPlayerDeal(), @

  dealDealer: -> new Hand @subsequentDealerDeal(), @, true

  subsequentPlayerDeal: ->
    [@getNextCard(), @getNextCard()]

  subsequentDealerDeal: ->
    [@getNextCard().flip(), @getNextCard()]

  getNextCard: ->
    nextCard = @pop()
    @unshift(nextCard)
    return nextCard

