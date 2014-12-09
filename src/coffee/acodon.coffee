$.fn.acodon = (options) ->

  root = $(this)

  # event wrapper
  supportTouch = "ontouchstart" of window
  touchStartEvent = (if supportTouch then "touchstart" else "mousedown")
  touchMoveEvent = (if supportTouch then "touchmove" else "mousemove")
  touchEndEvent = (if supportTouch then "touchend" else "mouseup")

  # option setting
  opts = $.extend({}, $.fn.acodon.defaults, options)

  root.each ->
    that = $(this)
    title = undefined
    detail = undefined
    moveFlg = false
    title = that.find(opts.header)
    detail = title.next()
    detail.hide()
    title.css "cursor", "pointer"

    # add class if option "addClass"
    if opts.addClass is true
      title.addClass "acodonTitle"
      detail.addClass "acodonDetail"

    # move した場合はフラグ付与
    if supportTouch
      title.on touchMoveEvent, ->
        moveFlg = true
        return

    # run when touch end
    title.on touchEndEvent, ->
      ele = $(this)
      if moveFlg
        moveFlg = false
        return false

      # remove current class
      title.removeClass "currentTitle"

      # toggle class
      if ele.next().css("display") isnt "none"
        ele.removeClass "currentTitle"
      else
        ele.addClass "currentTitle"

      # close all detail
      detail.slideUp().removeClass "currentDetail"

      # open tapped detail
      if ele.next().css("display") is "none"
        ele.next().slideDown().addClass "currentDetail"
      return

    return

  return


# default option
$.fn.acodon.defaults =
  header: "dt"
  addClass: false
