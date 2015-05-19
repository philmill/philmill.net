@PhilMill =
	version: '0.2'

@PhilMill.PagePreviewNav =
	init: ->
		ns = PhilMill.PagePreviewNav

		config =
			$sections: $('#content').find('.page-preview')
			$navLinks: $('#sidebar').find('a')
			currentLinkIndex: 0

		# find and animate current section and this index below upwards, hide current and move down, apply current to this
		config.$navLinks.on 'click', ->
			$newSection = config.$sections.eq($(@).index()).css { display:"visible" }
			$currentSection = $('#content').find('.page-preview--current')
			TweenLite.to($currentSection, 1, { top:"-600px", ease: Power3.easeInOut, onComplete: ns.hideCurrentSection, onCompleteScope: $currentSection })
			TweenLite.to($newSection, 1, { top: "15px", ease: Power3.easeInOut, onComplete: ns.addCurrentSection, onCompleteScope: $newSection })
			ns.updateNav(config, $newSection)
			false

	# find current link, remove the current label class and apply to new section
	updateNav: (config, newSection)->
		config.$navLinks.eq(config.currentLinkIndex).removeClass('current')
		config.currentLinkIndex = newSection.index('section.page-preview')
		config.$navLinks.eq(config.currentLinkIndex).addClass('current')

	hideCurrentSection: ->
		@.css { display:"none", top:"555px" }
		@.removeClass('page-preview--current')

	addCurrentSection: ->
		@.addClass('page-preview--current')

@PhilMill.City =
	init: ->
		$('.city-footer').each (index) ->
			maxX = $(@).width()
			maxY = $(@).height()
			image_url = $(@).data('img-url')

			i = 10
			while i -= 1
				$container = $("<div></div>").appendTo($(@))
				$("<img src='#{image_url}' alt='Building Image #{index}'/>").css({display:'none'}).appendTo($container).on 'load', ->
					r = 0.7*Math.random()
					TweenLite.set($(@), {display:'inline', scale: r, x:maxX*Math.random(), y:maxY*r})
					$imageClone = $(@).clone().appendTo($(@).parent())
					TweenLite.to($imageClone, 12*r, {y:-50, ease:Power3.easeOut, delay:10*r})

