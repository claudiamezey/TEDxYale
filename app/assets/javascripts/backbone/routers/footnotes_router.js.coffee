class TEDxYale.Routers.FootnotesRouter extends Backbone.Router
  
  initialize: (options) ->
    @speakers = new TEDxYale.Collections.Speakers(options.speakers)
      
  routes:
    ".*"        : "index"

  index: ->
    @view = new TEDxYale.Views.Footnotes.IndexView(@speakers)
            