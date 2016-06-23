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


$ ->

  new RLH.Modal()

  menuToggle = $('#js-mobile-menu').unbind()
  $('#js-navigation-menu').removeClass 'show'
  menuToggle.on 'click', (e) ->
    e.preventDefault()
    $('#js-navigation-menu').slideToggle ->
      if $('#js-navigation-menu').is(':hidden')
        $('#js-navigation-menu').removeAttr 'style'

  expanderTrigger = document.getElementById('js-expander-trigger')
  expanderContent = document.getElementById('js-expander-content')
  $('#js-expander-trigger').click ->
    $(this).toggleClass 'expander-hidden'

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

