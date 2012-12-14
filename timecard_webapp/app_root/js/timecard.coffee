jQuery ->
  class Timecard extends Backbone.Model
    initilize: () ->
      console.dir("Timecard#initialize")

  class TimecardList extends Backbone.Collection
    model: Timecard

  class TimecardView extends Backbone.View
    el: "#timecardDiv"
    events: "click button":"addTimecard"
    initialize:->
      console.dir("TimecardView#initialize")
      @collection = new TimecardList()
      @collection.bind("add", @render, @)

    render:(timecard)->
      $(@el).children("ul").append(@template(todo))

    addTimecard: ()->
      timecard = new Timecard({content:$("#new-timecard").cal()})
      @collection.add(timecard)

    template: (timecard)->
      "<li>"+timecard.get("content")+"</li>"

  timecard_view = new TimecardView()

