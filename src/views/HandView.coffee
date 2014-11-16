class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'change remove reset add', => @scoreUpdate()
    @collection.on 'remove reset', => @render()
    @collection.on 'add', => @appendNewCard()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text(@collection.legitScore())

  appendNewCard: ->
    @$el.append(new CardView(model: @collection.last()).$el)

  scoreUpdate: ->
    @$('.score').text(@collection.legitScore())

