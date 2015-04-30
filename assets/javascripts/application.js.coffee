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
  init: ->
    $bg = $('#city-footer')
    maxX = $bg.width()
    maxY = $bg.height()
    test_url = $bg.data('img-url')

    i = 10
    while i -= 1
      $container = $("<div></div>").appendTo($bg)
      $("<img src='#{test_url}' alt='Building Image'/>").css({display:'none'}).appendTo($container).on 'load', ->
        w = $(this).width()
        h = $(this).height()
        r = 0.7*Math.random()
        #$(this).css {width:w/3, height:h/3, left:maxX*Math.random()}
        TweenLite.set($(this), {display:'inline', scale: r, x:maxX*Math.random(), y:maxY*r})
        $imageClone = $(this).clone().appendTo($(this).parent())
        TweenLite.to($imageClone, 1.5, {y:-50, ease:Power3.easeOut, delay:2*r})
