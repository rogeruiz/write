const YT_PATTERN = /^https?:\/\/www.youtube.com/i;

const YT_CLASS_NAME = 'js-yt-embed';

export default {

  youtubeElements: undefined,

  registerEmbedElements: function() {

    var iframeElements = document.getElementsByTagName( 'iframe' );

    var elements = Array.prototype.slice.call( iframeElements );

    this.youtubeElements = elements.filter( function( el, idx, arr ) {

      return YT_PATTERN.test( el.src );

    } );

    if ( this.youtubeElements.length ) {

      this.youtubeElements.forEach( function( el, idx, arr ) {

        var h = el.height;
        var w = el.width;

        el.dataset.aspectRatio = h / w;
        el.setAttribute( 'class', YT_CLASS_NAME );
        el.removeAttribute( 'width' );
        el.removeAttribute( 'height' );

      } );

      this.resizeEmbedElements();

    }

  },

  resizeEmbedElements: function() {

    if ( this.youtubeElements ) {

      this.youtubeElements.forEach( function( el, idx, arr ) {

        var container = el.parentNode;
        var newWidth = container.clientWidth;

        el.width = newWidth;
        el.height = newWidth * el.dataset.aspectRatio;

      } );

    }

  },

}
