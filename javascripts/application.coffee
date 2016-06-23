---
---

if typeof window.RLH is 'undefined' then window.RLH = {}



class RLH.Modal

  constructor: ->
    @events()

  events: ->
    $('[data-role=modal-trigger]').on 'click', @open
    $('.modal-fade-screen, .modal-close').on 'click', @close
    $('.modal-state').on 'change', @changeState

  open: ->
    id = $(this).attr('href')
    $(id).find('.modal-state').prop('checked', true)
    false

  close: ->
    $('.modal-state:checked').prop('checked', false).change()

  changeState: ->
    if $(this).is(':checked')
      $('body').addClass 'modal-open'
    else
      $('body').removeClass 'modal-open'



class RLH.Flickr

  constructor: (@userId, @apiKey) ->
    @el = $('.single-item')
    @el.slick
      adaptiveHeight: true
      arrows: false
    @photos = []
    @request()
    @events()

  events: ->
    $('[data-role=slick-prev]').on 'click', @previous
    $('[data-role=slick-next]').on 'click', @next

  request: ->
    $.ajax
      dataType: "json"
      url: "https://api.flickr.com/services/rest/?&method=flickr.people.getPublicPhotos&api_key=#{@apiKey}&user_id=#{@userId}&format=json&jsoncallback=?&per_page=10"
      success: @success

  success: (data) =>
    $.each data.photos.photo, (i, photo) =>
      el = $('<img />').attr('src', @buildUrl(photo))
      @el.slick('slickAdd', el)

  buildUrl: (photo, size='z') =>
    "https://farm#{photo.farm}.staticflickr.com/#{photo.server}/#{photo.id}_#{photo.secret}_#{size}.jpg"

  next: =>
    @el.slick('slickNext')
    false

  previous: =>
    @el.slick('slickPrev')
    false


class RLH.Drawers

  constructor: ->
    $('[data-role=expand]').on 'click', @click

  click: ->
    $(this).toggleClass 'expander-hidden'


$ ->

  new RLH.Flickr('39333276@N07', '5226a951238722dbb74e03a6acce5ad5')
  new RLH.Modal()
  new RLH.Drawers()

  menuToggle = $('#js-mobile-menu').unbind()
  $('#js-navigation-menu').removeClass 'show'
  menuToggle.on 'click', (e) ->
    e.preventDefault()
    $('#js-navigation-menu').slideToggle ->
      if $('#js-navigation-menu').is(':hidden')
        $('#js-navigation-menu').removeAttr 'style'

  do (jQuery) ->
    jQuery.mark = jump: (options) ->
      defaults = selector: 'a.scroll-on-page-link'
      if typeof options == 'string'
        defaults.selector = options
      options = jQuery.extend(defaults, options)
      jQuery(options.selector).click (e) ->
        jumpobj = jQuery(this)
        target = jumpobj.attr('href')
        thespeed = 1000
        offset = jQuery(target).offset().top
        jQuery('html,body').animate { scrollTop: offset }, thespeed, 'swing'
        e.preventDefault()
        return
    return
  jQuery ->
    jQuery.mark.jump()
    return

