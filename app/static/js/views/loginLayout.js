(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone", "marionette", "loudr.config"], function(Backbone, Marionette, LoudrConfig) {
    var LoudrLogin, _ref;
    LoudrLogin = (function(_super) {
      __extends(LoudrLogin, _super);

      function LoudrLogin() {
        _ref = LoudrLogin.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      LoudrLogin.prototype.initialize = function(options) {
        return LoudrConfig.app.displayTitle("Login");
      };

      LoudrLogin.prototype.events = {
        "submit form": "attempt_login"
      };

      LoudrLogin.prototype.template = "#login_template";

      LoudrLogin.prototype.attempt_login = function(e) {
        var email, password;
        e.preventDefault();
        email = this.$('input[name="email"]').val();
        password = this.$('input[name="password"]').val();
        return LoudrConfig.auth.login(email, password, function(success) {
          if (success) {
            Backbone.history.navigate('/', {
              trigger: true
            });
          }
        });
      };

      return LoudrLogin;

    })(Marionette.Layout);
    return LoudrLogin;
  });

}).call(this);
