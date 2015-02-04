angular.module('sessionService', [])
  .factory('Session', ['$location', '$http', '$q', '$rootScope', '$route', function($location, $http, $q, $rootScope, $route) {
      // Redirect to the given url (defaults to '/')
      function redirect(url) {
        url = url || '/';
        $location.path(url);
      }
      var service = {
        login: function(email, password) {
          return $http.post('/api/sessions', {user: {email: email, password: password} })
            .success(function(response) {
              service.currentUser = response.user;
              if (!!service.currentUser) {
                $rootScope.$broadcast('authLoginSuccess');
                redirect('/');
              }
            });
        },

        logout: function(redirectTo) {
          $http.delete('/api/sessions').then(function(response) {
            $http.defaults.headers.common['X-CSRF-Token'] = response.data.csrfToken;
            service.currentUser = null;
            redirect(redirectTo);
          });
        },
        requestCurrentUser: function() {
          if (!!service.currentUser) {
            return $q.when(service.currentUser);
          } else {
            return $http.get('/api/users').then(function(response) {
              service.currentUser = response.data.user;
              return service.currentUser;
            });
          }
        },

        currentUser: null,

        isAuthenticated: function(){
          return !!service.currentUser;
        }
      };
      service.requestCurrentUser();
      return service;
  }]);
