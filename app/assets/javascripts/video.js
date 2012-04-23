(function($) {
  $.fn.makeVideosCompatible = function() {
    if(_canPlayVideo()) {
      return $(this);
    }
    else {
      var videos = this;
      return videos.filter('video[data-uuid!=""]').each(function() {
        $(this).replaceVideoWith($(this).data('uuid'));
      });
    }
  };

  $.fn.replaceVideoWith = function(uuid) {
    return $($.createVideoHTML(uuid, $(this).attr('width'), $(this).attr('height'))).replaceAll($(this)).stopOtherVideosWhenPlayed();
  };

  $.fn.stopOtherVideosWhenPlayed = function() {
    var videos = this;
    return videos.filter('video').bind('play', function() {
      $('video').not($(this)).trigger('pause');
    });
  };

  function _canPlayVideo() {
    if(document.createElement('video').canPlayType != null && document.createElement('video').canPlayType('video/mp4')) {
      return true;
    }
    else {
      return false;
    }
  }

  $.createVideoHTML = function(uuid, width, height) {
    var video_url = document.location.protocol + '//s3.amazonaws.com/protopipe_videos/' + uuid + '.mp4'

    if(_canPlayVideo()) {
      return '<video class="video_player" controls="true" preload="none" '
        + 'width="' + width + '" '
        + 'height="' + height + '" '
        + 'poster="' + video_url + '_50.jpg">'
          + '<source type="video/mp4" src="' + video_url + '" />'
        + '</video>';
    }
    else {
      var flash_vars = 'displayheight=' + height +
        '&file=' + video_url +
        '&image=' + video_url + '_50.jpg' +
        '&width=' + width +
        '&height=' + height;

      /* object tags need an id attribute */
      return '<object classid="clsid:D27CDB6E-AE6D-11CF-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,115,0" '
        + 'id="flash_' + uuid + '" '
        + 'class="video_player" '
        + 'width="' + width + '" '
        + 'height="' + height +'">'
        + '<param name="movie" value="/static_assets/player.swf" />'
        + '<param name="allowFullScreen" value="true" />'
        + '<param name="wmode" value="transparent" />'
        + '<param name="allowScriptAccess" value="always" />'
        + '<param name="flashvars" value="' + flash_vars + '" />'
        + '<embed src="/static_assets/player.swf" allowfullscreen="true" allowscriptaccess="always" wmode="transparent" type="application/x-shockwave-flash" '
          + 'pluginspage="http://www.macromedia.com/go/getflashplayer" width="' + width + '" height="' + height + '" flashvars="' + flash_vars + '" />'
        + '</object>';
    }
  };

  $.videoThumbnailURL = function(uuid) {
    return document.location.protocol + '//s3.amazonaws.com/protopipe_videos/' + uuid + '.mp4_50_thumb.jpg';
  };
})(jQuery);