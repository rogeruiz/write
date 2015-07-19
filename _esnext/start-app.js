import embeds from 'embeds';

export default function() {

  embeds.registerEmbedElements();

  if ( window.addEventListener ) {

    window.addEventListener( 'resize', function() {

      embeds.resizeEmbedElements();

    } );

  }

}
