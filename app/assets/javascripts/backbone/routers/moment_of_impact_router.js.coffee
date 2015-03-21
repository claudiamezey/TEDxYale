class TEDxYale.Routers.MomentOfImpactRouter extends Backbone.Router
  
  initialize: (options) ->
    @speakers = new TEDxYale.Collections.Speakers(options.speakers)
      
  routes:
    ".*"        : "index"

  index: ->
    @view = new TEDxYale.Views.MomentOfImpact.IndexView(@speakers)
            