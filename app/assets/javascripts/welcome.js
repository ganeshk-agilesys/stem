$(function() {

  $('a.video').click(function(event) {
    //$('a.video').removeClass('selected');
    //$(this).addClass('selected');

    $('div.video-container[data-group=' + $(this).data('group') +']').children('video, object').replaceVideoWith($(this).data('uuid'));
    event.preventDefault();
  });

  $('.video-container:has(video) ~ div.scrollable_container').each(function() {
    // pick a random video
    var random_video = $(this).find('.scrollable div.items div:not(.cloned) a')
      .sort(function(){
        return Math.round(Math.random())-0.5;
      })
      .first();

    // scroll to the page with the random video
    var page = random_video.closest('div.items').find('div:not(.cloned)').index(random_video.parent());
    //$(this).find('.scrollable').data('scrollable').seekTo(page, 200);

    // load the random video
    random_video.trigger('click');
  });
});