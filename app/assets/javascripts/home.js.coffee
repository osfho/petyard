###
 Slides, A Slideshow Plugin for jQuery
 Intructions: http://slidesjs.com
 By: Nathan Searles, http://nathansearles.com
 Version: 1.1.9
 Updated: September 5th, 2011

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
###

((a) ->
  a.fn.slides = (b) ->
    b = a.extend({}, a.fn.slides.option, b)
    @each(->
      w = (g, h, i) ->
        if not p and o
          p = not 0
          b.animationStart(n + 1)

          switch g
            when "next"
              l = n
              k = n + 1
              k = (if e is k then 0 else k)
              r = f * 2
              g = -f * 2
              n = k
            when "prev"
              l = n
              k = n - 1
              k = (if k is -1 then e - 1 else k)
              r = 0
              g = 0
              n = k
            when "pagination"
              k = parseInt(i, 10)
              l = a("." + b.paginationClass + " li." + b.currentClass + " a", c).attr("href").match("[^#/]+$")
              (if k > l then (r = f * 2
              g = -f * 2
              ) else (r = 0
              g = 0
              ))
              n = k
          (if h is "fade" then (if b.crossfade then d.children(":eq(" + k + ")", c).css(zIndex: 10).fadeIn(b.fadeSpeed, b.fadeEasing, ->
            (if b.autoHeight then d.animate(
              height: d.children(":eq(" + k + ")", c).outerHeight()
            , b.autoHeightSpeed, ->
              d.children(":eq(" + l + ")", c).css(
                display: "none"
                zIndex: 0
              )
              d.children(":eq(" + k + ")", c).css(zIndex: 0)
              b.animationComplete(k + 1)
              p = not 1
            ) else (d.children(":eq(" + l + ")", c).css(
              display: "none"
              zIndex: 0
            )
            d.children(":eq(" + k + ")", c).css(zIndex: 0)
            b.animationComplete(k + 1)
            p = not 1
            ))
          ) else d.children(":eq(" + l + ")", c).fadeOut(b.fadeSpeed, b.fadeEasing, ->
            (if b.autoHeight then d.animate(
              height: d.children(":eq(" + k + ")", c).outerHeight()
            , b.autoHeightSpeed, ->
              d.children(":eq(" + k + ")", c).fadeIn b.fadeSpeed, b.fadeEasing
            ) else d.children(":eq(" + k + ")", c).fadeIn(b.fadeSpeed, b.fadeEasing, ->
              a.browser.msie and a(this).get(0).style.removeAttribute("filter")
            ))
            b.animationComplete(k + 1)
            p = not 1
          )) else (d.children(":eq(" + k + ")").css(
            left: r
            display: "block"
          )
          (if b.autoHeight then d.animate(
            left: g
            height: d.children(":eq(" + k + ")").outerHeight()
          , b.slideSpeed, b.slideEasing, ->
            d.css(left: -f)
            d.children(":eq(" + k + ")").css(
              left: f
              zIndex: 5
            )
            d.children(":eq(" + l + ")").css(
              left: f
              display: "none"
              zIndex: 0
            )
            b.animationComplete(k + 1)
            p = not 1
          ) else d.animate(
            left: g
          , b.slideSpeed, b.slideEasing, ->
            d.css(left: -f)
            d.children(":eq(" + k + ")").css(
              left: f
              zIndex: 5
            )
            d.children(":eq(" + l + ")").css(
              left: f
              display: "none"
              zIndex: 0
            )
            b.animationComplete(k + 1)
            p = not 1
          ))
          ))
          b.pagination and (a("." + b.paginationClass + " li." + b.currentClass, c).removeClass(b.currentClass)
          a("." + b.paginationClass + " li:eq(" + k + ")", c).addClass(b.currentClass)
          )
      x = ->
        clearInterval c.data("interval")
      y = ->
        (if b.pause then (clearTimeout(c.data("pause"))
        clearInterval(c.data("interval"))
        u = setTimeout(->
          clearTimeout(c.data("pause"))
          v = setInterval(->
            w "next", i
          , b.play)
          c.data("interval", v)
        , b.pause)
        c.data("pause", u)
        ) else x())
      a("." + b.container, a(this)).children().wrapAll "<div class=\"slides_control\"/>"
      c = a(this)
      d = a(".slides_control", c)
      e = d.children().size()
      f = d.children().outerWidth()
      g = d.children().outerHeight()
      h = b.start - 1
      i = (if b.effect.indexOf(",") < 0 then b.effect else b.effect.replace(" ", "").split(",")[0])
      j = (if b.effect.indexOf(",") < 0 then i else b.effect.replace(" ", "").split(",")[1])
      k = 0
      l = 0
      m = 0
      n = 0
      o = undefined
      p = undefined
      q = undefined
      r = undefined
      s = undefined
      t = undefined
      u = undefined
      v = undefined
      if e < 2
        return a("." + b.container, a(this)).fadeIn(b.fadeSpeed, b.fadeEasing, ->
          o = not 0
          b.slidesLoaded()
        )
        a("." + b.next + ", ." + b.prev).fadeOut(0)
        not 1
      return  if e < 2
      h < 0 and (h = 0)
      h > e and (h = e - 1)
      b.start and (n = h)
      b.randomize and d.randomize()
      a("." + b.container, c).css(
        overflow: "hidden"
        position: "relative"
      )
      d.children().css(
        position: "absolute"
        top: 0
        left: d.children().outerWidth()
        zIndex: 0
        display: "none"
      )
      d.css(
        position: "relative"
        width: f * 3
        height: g
        left: -f
      )
      a("." + b.container, c).css(display: "block")
      b.autoHeight and (d.children().css(height: "auto")
      d.animate(
        height: d.children(":eq(" + h + ")").outerHeight()
      , b.autoHeightSpeed)
      )

      if b.preload and d.find("img:eq(" + h + ")").length
        a("." + b.container, c).css background: "url(" + b.preloadImage + ") no-repeat 50% 50%"
        z = d.find("img:eq(" + h + ")").attr("src") + "?" + (new Date).getTime()
        (if a("img", c).parent().attr("class") isnt "slides_control" then t = d.children(":eq(0)")[0].tagName.toLowerCase() else t = d.find("img:eq(" + h + ")"))
        d.find("img:eq(" + h + ")").attr("src", z).load(->
          d.find(t + ":eq(" + h + ")").fadeIn b.fadeSpeed, b.fadeEasing, ->
            a(this).css(zIndex: 5)
            a("." + b.container, c).css(background: "")
            o = not 0
            b.slidesLoaded()

        )
      else
        d.children(":eq(" + h + ")").fadeIn b.fadeSpeed, b.fadeEasing, ->
          o = not 0
          b.slidesLoaded()

      b.bigTarget and (d.children().css(cursor: "pointer")
      d.children().click(->
        w("next", i)
        not 1
      )
      )
      b.hoverPause and b.play and (d.bind("mouseover", ->
        x()
      )
      d.bind("mouseleave", ->
        y()
      )
      )
      b.generateNextPrev and (a("." + b.container, c).after("<a href=\"#\" class=\"" + b.prev + "\">Prev</a>")
      a("." + b.prev, c).after("<a href=\"#\" class=\"" + b.next + "\">Next</a>")
      )
      a("." + b.next, c).click((a) ->
        a.preventDefault()
        b.play and y()
        w("next", i)
      )
      a("." + b.prev, c).click((a) ->
        a.preventDefault()
        b.play and y()
        w("prev", i)
      )
      (if b.generatePagination then ((if b.prependPagination then c.prepend("<ul class=" + b.paginationClass + "></ul>") else c.append("<ul class=" + b.paginationClass + "></ul>"))
      d.children().each(->
        a("." + b.paginationClass, c).append("<li><a href=\"#" + m + "\">" + (m + 1) + "</a></li>")
        m++
      )
      ) else a("." + b.paginationClass + " li a", c).each(->
        a(this).attr("href", "#" + m)
        m++
      ))
      a("." + b.paginationClass + " li:eq(" + h + ")", c).addClass(b.currentClass)
      a("." + b.paginationClass + " li a", c).click(->
        b.play and y()
        q = a(this).attr("href").match("[^#/]+$")
        n isnt q and w("pagination", j, q)
        not 1
      )
      a("a.link", c).click(->
        b.play and y()
        q = a(this).attr("href").match("[^#/]+$") - 1
        n isnt q and w("pagination", j, q)
        not 1
      )
      b.play and (v = setInterval(->
        w "next", i
      , b.play)
      c.data("interval", v)
      )
    )

  a.fn.slides.option =
    preload: not 1
    preloadImage: "/img/loading.gif"
    container: "slides_container"
    generateNextPrev: not 1
    next: "next"
    prev: "prev"
    pagination: not 0
    generatePagination: not 0
    prependPagination: not 1
    paginationClass: "pagination"
    currentClass: "current"
    fadeSpeed: 350
    fadeEasing: ""
    slideSpeed: 350
    slideEasing: ""
    start: 1
    effect: "slide"
    crossfade: not 1
    randomize: not 1
    play: 0
    pause: 0
    hoverPause: not 1
    autoHeight: not 1
    autoHeightSpeed: 350
    bigTarget: not 1
    animationStart: ->

    animationComplete: ->

    slidesLoaded: ->

  a.fn.randomize = (b) ->
    c = ->
      Math.round(Math.random()) - .5
    a(this).each ->
      d = a(this)
      e = d.children()
      f = e.length
      if f > 1
        e.hide()
        g = []
        i = 0
        while i < f
          g[g.length] = i
          i++
        g = g.sort(c)
        a.each(g, (a, c) ->
          f = e.eq(c)
          g = f.clone(not 0)
          g.show().appendTo(d)
          b isnt `undefined` and b(f, g)
          f.remove()
        )

) jQuery
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