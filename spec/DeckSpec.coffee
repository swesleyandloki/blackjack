assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'hand hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 50
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 49

  describe 'hand stand', ->
    it 'should not be able to hit again once stand is called', ->
      length = hand.length
      hand.stand()
      hand.hit()
      assert.strictEqual length, hand.length
