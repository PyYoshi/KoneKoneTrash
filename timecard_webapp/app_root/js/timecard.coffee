jQuery ->

  ##################################
  #
  # モデル定義
  #
  ##################################
  class Timecard extends Backbone.Model
    defaults: ()->
      ret = {
        title:"empty timecard..."
        order: Timecards.nextOrder()
        done: false
      }
      return ret

    initialize: ()->
      if !@get('title') then @set({title:@defaults().title})
      return

    toggle: ()->
      @save({done: !@get('done')})
      return

  ##################################
  #
  # コレクション定義
  #
  ##################################
  class TimecardList extends Backbone.Collection
    model:Timecard
    localStorage: new Backbone.LocalStorage("timecard-backbone")

    done: ()->
      return @filter(
        (timecard)->
          return timecard.get('done')
      )

    remaining: ()->
      return @without.apply(@, @done())

    nextOrder: ()->
      if !@length then return 1
      return @last().get('order') + 1

    comparator: (timecard)->
      return timecard.get('order')

  Timecards = new TimecardList()

  ##################################
  #
  # ビュー定義
  #
  ##################################

  class TimecardView extends Backbone.View

    tagName: 'li'

    template: _.template($('#item-template').html())

    events: {
      "click .toggle"   : "toggleDone"
      "dblclick .view"  : "edit"
      "click a.destroy" : "clear"
      "keypress .edit"  : "updateOnEnter"
      "blur .edit"      : "close"
    }

    #インスタンス生成時に実行
    initialize:->
      @model.on('change', @render, @)
      @model.on('destroy', @remove, @)

    #render
    render:() ->
      @$el.html(@template(@model.toJSON()))
      @$el.toggleClass('done', @model.get('done'))
      @input = @$('.edit')
      return @

    toggleDone: ()->
      @model.toggle()
      return

    edit: ()->
      @$el.addClass('editing')
      @input.focus()

    close: ()->
      value = @input.val()
      if !value
        @clear()
      else
        @model.save({title:value})
        @$el.removeClass('editing')

    updateOnEnter: (e)->
      if e.keyCode == 13 then @close()
      return

    clear: ()->
      @model.destroy()
      return

  class AppView extends Backbone.View
    el: $('#timecardApp')
    statsTemplate: _.template($('#stats-template').html())
    events:{
      "keypress #new-timecard":  "createOnEnter"
      "click #clear-completed": "clearCompleted"
      "click #toggle-all": "toggleAllComplete"
    }

    initialize: ()->
      @input = @$('#new-timecard')

      Timecards.on('add', @addOne, @)
      Timecards.on('reset', @addAll, @)
      Timecards.on('all', @render, @)

      @footer = @$('footer')
      @main = $('#main')

      Timecards.fetch()

    render:()->
      done = Timecards.done().length
      remaining = Timecards.remaining().length

      if Timecards.length
        @main.show()
        @footer.show()
        @footer.html(@statsTemplate({done:done, remaining: remaining}))
      else
        @main.hide()
        @footer.hide()

      return

    addOne: (timecard)->
      view = new TimecardView({model: timecard})
      @$('#timecard-list').append(view.render().el)
      return

    addAll: ()->
      Timecards.each(@addOne)
      return

    createOnEnter:(e)->
      if e.keyCode != 13 then return
      if !@input.val() then return

      Timecards.create({title:@input.val()})
      @input.val('')
      return

    clearCompleted: ()->
      _.invoke(Timecards.done(), 'destroy')
      return false

    toggleAllComplete: ()->
      Timecards.each(
        (timecard)->
          timecard.save({done:done})
          return
      )
      return

  #ビューをインスタンス化
  App = new AppView()


