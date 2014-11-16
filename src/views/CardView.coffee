class window.CardView extends Backbone.View
  className: 'flip'

  template: _.template '
  <div class="card">
    <div class="front face">
      <img src="img/card-back.png"/>
    </div>
    <div class="back face">
      <img src="img/cards/<%= rankName %>-<%= suitName %>.png"/>

    </div>
  </div>'

  initialize: ->
    @render()
    @model.on('change:revealed', @prettyFlip, @)


  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    # @$el.addClass 'covered' unless @model.get 'revealed'
    setTimeout(=>
      @prettyFlip()
    ,1000)

  prettyFlip: ->
    if @model.get 'revealed'
      @$('.card').addClass 'flipped'
