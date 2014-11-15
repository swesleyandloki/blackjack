class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> new Hand [@getNextCard(), @getNextCard()], @

  dealDealer: -> new Hand [@getNextCard().flip(), @getNextCard()], @, true

  subsequentPlayerDeal: ->
    [@getNextCard(), @getNextCard()]

  subsequentDealerDeal: ->
    [@getNextCard().flip(), @getNextCard()]

  getNextCard: ->
    nextCard = @pop()
    @unshift(nextCard)
    return nextCard

