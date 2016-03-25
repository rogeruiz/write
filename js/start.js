'use strict';

requirejs.config( {
  baseUrl: '/js',
  paths: {
    'jquery': '../bower_components/jquery/dist/jquery',
    'v/rsvp': '../bower_components/rsvp/rsvp',
  },
  map: {
    '*': {
      'v/jquery': 'jquery-private',
    },
    'jquery-private': {
      'v/jquery': 'jquery',
    },
  },
} );

define( 'start', function ( require ) {
  return function () {
    var $ = require('jquery');
    var ytembeds = require('yt-embeds');

    ytembeds.registerEmbedElements();

    $( window ).resize( function () {
      ytembeds.resizeEmbedElements();
    } );

  };
} );

( function ( global ) {

  var d = global.document;
  var require = global.require;

  if ( d.addEventListener ) {

    d.addEventListener( 'DOMContentLoaded', function () {
      require( [ 'start' ], function ( s ) { s(); } );
    } );

  }

} )( this );
