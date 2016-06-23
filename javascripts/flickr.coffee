---
---

if typeof window.RLH is 'undefined' then window.RLH = {}



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



$ -> new RLH.Flickr('39333276@N07', '5226a951238722dbb74e03a6acce5ad5')

