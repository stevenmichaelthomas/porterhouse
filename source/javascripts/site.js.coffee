#= require lib/request_animation_frame
#= require lib/scroll_animation
#= require lib/jquery.autosize

$body = $(document.body)

#-----------------------------------------------------------------------------
# Autosize
#-----------------------------------------------------------------------------

$body.find('textarea.autosize').autosize(append: '\n')

#-----------------------------------------------------------------------------
# Run scroll animations
#-----------------------------------------------------------------------------

ScrollAnimation.start()

#-----------------------------------------------------------------------------
# Pretty scroll to
#-----------------------------------------------------------------------------

$body.on 'click', 'a', (event) ->
  if this.host == window.location.host && this.pathname == window.location.pathname && this.hash
    hash    = this.hash
    $target = $(this.hash)

    if $target.length
      event.preventDefault()
      window.history?.replaceState({}, document.title, hash)
      $body
        .stop()
        .animate(scrollTop: $target.offset().top - 30, 500)
