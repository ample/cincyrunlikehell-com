---
---

$ ->

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
    return
  return
