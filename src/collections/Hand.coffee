class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    if @canPlay
      newCard = @deck.pop()
      @add(newCard)
      newCard

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  canPlay: true

  stand: ->
    if @canPlay
      @canPlay = false
      return

  playDealer: ->
    if @isDealer
      console.log 'dealer turn'
      @at(0).flip()
      # if either score is above 17 we stop
      # if both are over 21 we are bust
      # if both are under 17 we deal another card
      while @scores()[1] < 17
        @hit()
        console.log('minscore', @scores()[0])
      if @isBust()
        console.log('im bust')
      @trigger('handsUp', @)


  isBust: ->
    @minScore() > 21

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


