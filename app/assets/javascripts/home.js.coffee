#SlidesJS controls
jQuery
$ ->
  $("#feature").slides
    preload: true
    generatePagination: false
    effect: "fade"
    crossfade: true
    play: 7000
    pause: 2500


# Twitter follow object (twitter.com)
not ((d, s, id) ->
  js = undefined
  fjs = d.getElementsByTagName(s)[0]
  unless d.getElementById(id)
    js = d.createElement(s)
    js.id = id
    js.src = "//platform.twitter.com/widgets.js"
    fjs.parentNode.insertBefore js, fjs
) document, "script", "twitter-wjs"

###
  Polling for online player updates, 
  with entirely too much help from
  Railscasts (http://railscasts.com/episodes/229-polling-for-changes-revised)
###
@PlayerPoller = 
  poll: ->
    setTimeout @request, 1500

  request: ->
    $.get($('#players_online').data('url'))

jQuery ->
  if $('#players_online').length > 0
    PlayerPoller.poll()