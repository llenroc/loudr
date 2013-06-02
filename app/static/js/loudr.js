(function() {
  require.config({
    paths: {
      backbone: '/js/vendor/backbone',
      underscore: '/js/vendor/underscore',
      jquery: '/js/vendor/jquery-1.9.1.min',
      marionette: '/js/vendor/backbone.marionette',
      'backbone.wreqr': '/js/vendor/backbone.wreqr',
      'backbone.babysitter': '/js/vendor/backbone.babysitter'
    },
    shim: {
      jquery: {
        exports: 'jQuery'
      },
      underscore: {
        exports: '_'
      },
      backbone: {
        deps: ['jquery', 'underscore'],
        exports: 'Backbone'
      }
    }
  });

  define(["marionette"], function(Marionette) {
    var LoudrApp;

    LoudrApp = new Marionette.Application();
    console.log(LoudrApp);
    return LoudrApp;
  });

}).call(this);
