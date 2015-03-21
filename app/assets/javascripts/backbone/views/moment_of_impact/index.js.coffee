TEDxYale.Views.MomentOfImpact ||= {}

class TEDxYale.Views.MomentOfImpact.IndexView extends Backbone.View
  
  # Templates
  template: JST["backbone/templates/moment_of_impact/index"]
  speakerTemplate: JST["backbone/templates/moment_of_impact/speaker"]
  speakerModal: JST["backbone/templates/moment_of_impact/speaker-modal"]
  
  el: 'body'
  
  sentences: [
    "As we've organized TEDxYale year after year, we've observed that the most meaningful TED talks often present the simplest of stories.",
    "Speakers don't focus on what they've done but what they've thought and felt.",
    "This year's TEDxYale challenges our speakers to share an idea or story they haven't had an opportunity to share before.",
    "We're calling it...",
    "Exploring the Footnotes."
  ]
  
  initialize: (speakers) ->
    $(@el).html(@template())
    @speakers = speakers
    @currentIndex = 0
    @typeSentence(0) # 0 represents zero index
  
  typeSentence: =>
    text = @sentences[@currentIndex]
    for char, i in text
      rand = Math.random() * 10
      _.delay(@appendChar, (30 * i) + rand, char);
    _.delay(@clearText, text.length * 40)
    @currentIndex += 1
    
  clearText: =>
    if @currentIndex < @sentences.length
      $('#text').fadeOut(600, ->
        $('#text').html('').show()
      )
      _.delay(@typeSentence, 700)
    else if !@skipped
      _.delay ->
        $('#text').fadeOut(1000, ->
          $('#text').html('').show()
        )
      , 500
      _.delay(@render, 1500)
      
  appendChar: (char) ->
    $('#text').append(char)
  
  renderSpeakers: ->
    for speaker in @speakers.models
      $('#speakers').append @speakerTemplate(speaker.toJSON())
     
  render: =>
    $('#skip').fadeOut(300)
    _.delay ->
      $('.open-links').fadeIn(500)
    , 300
    $('.footnotes-content').addClass 'open'
    @renderSpeakers()
    return this
    
  events:
    "click #skip" : "skipIntro"
    "click .footnotes-speaker" : "openSpeaker"
    "click #close-modal" : "closeSpeaker"
  
  skipIntro: ->
    unless @skipped
      @skipped = true
      @currentIndex = @sentences.length
      $('#text').fadeOut(500)
      $('#skip').fadeOut(200)
      _.delay(@render, 400)

  openSpeaker: (event) ->
    id = $(event.target).closest('.footnotes-speaker').data('id')
    speaker = @speakers.get(id)
    $('#speaker-name').html speaker.get('name')
    $('#speaker').html @speakerModal(speaker.toJSON())
    $('#footnotes-modal').addClass 'open'
  
  closeSpeaker: (event) ->
    $('#footnotes-modal').removeClass 'open'
  