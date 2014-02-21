@PhilMill =
  version: '0.1'

@PhilMill.PagePreviewNav =
  init: ->
    ns = PhilMill.PagePreviewNav

    config =
      sections: $('#content').find('.page-preview')
      navLinks: $('#sidebar').find('a')
      currentLink: 0

    config.navLinks.on 'click', ->
      # find and animate current section and this index below upwards, hide current and move down, apply current to this
      newSection = config.sections.eq($(this).index()).css {display:"visible"}
      currentSection = $('#content').find '.page-preview--current'
      TweenLite.to(currentSection, 1, {top:"-600px", ease: Power3.easeInOut, onComplete: ns.hideCurrentSection, onCompleteScope: currentSection})
      TweenLite.to(newSection, 1, {top: "15px", ease: Power3.easeInOut, onComplete: ns.addCurrentSection, onCompleteScope: newSection})
      ns.updateNav(config, newSection)
      false

  # find current link, remove the current label class and apply to new section
  updateNav: (config, newSection)->
    config.navLinks.eq(config.currentLink).removeClass 'current'
    config.currentLink = newSection.index 'section.page-preview'
    config.navLinks.eq(config.currentLink).addClass 'current'

  hideCurrentSection: ->
    this.css {display:"none", top:"555px"}
    this.removeClass 'page-preview--current'

  addCurrentSection: ->
    this.addClass 'page-preview--current'

@PhilMill.City =
  # TODO: load image onto canvas tag and transform the canvas or need an on load to handle image load
  init: ->
    bg = $('#city-footer')
    maxX = bg.width()/2
    test_url = bg.data('img-url')

    i = 15
    while i -= 1
      building = $("<img src="+test_url+"/>").appendTo(bg)
      TweenLite.set(building, {scale:Math.random()-0.3, left:maxX*Math.random()})
