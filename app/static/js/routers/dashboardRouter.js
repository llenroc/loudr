(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone", "marionette", 'loudr.config', "views/dashboardLayout", "models/projectModel", "views/projectList", "views/loginLayout", "views/registerLayout"], function(Backbone, Marionette, LoudrConfig, DashboardLayout, ProjectCollection, ProjectCollectionView, LoginLayout, RegisterLayout) {
    var DashboardRouter, _ref;
    DashboardRouter = (function(_super) {
      __extends(DashboardRouter, _super);

      function DashboardRouter() {
        _ref = DashboardRouter.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      DashboardRouter.prototype.controller = {
        home: function() {
          var dash, project_collection, project_collection_view;
          dash = new DashboardLayout();
          project_collection = new ProjectCollection;
          project_collection_view = new ProjectCollectionView({
            collection: project_collection
          });
          project_collection.fetch({
            error: function(err, blah, doh) {
              if (doh.xhr.status === 401) {
                return Backbone.history.navigate('login', {
                  trigger: true
                });
              }
            }
          });
          LoudrConfig.app.mainRegion.show(dash);
          return dash.projectsRegion.show(project_collection_view);
        },
        register: function() {
          var login;
          login = new RegisterLayout();
          return LoudrConfig.app.mainRegion.show(login);
        },
        login: function() {
          var login;
          login = new LoginLayout();
          LoudrConfig.app.mainRegion.show(login);
          return LoudrConfig.nav.collection.show_logged_out_nav();
        },
        logout: function() {
          return LoudrConfig.app.auth.logout(function() {
            return Backbone.history.navigate('login', {
              trigger: true
            });
          });
        }
      };

      DashboardRouter.prototype.appRoutes = {
        "": "home",
        "register": "register",
        "login": "login",
        "logout": "logout"
      };

      return DashboardRouter;

    })(Marionette.AppRouter);
    return DashboardRouter;
  });

}).call(this);
