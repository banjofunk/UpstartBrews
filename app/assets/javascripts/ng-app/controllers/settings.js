angular.module('AngularUpstart')
  .controller('SettingsCtrl', function ($scope, $location, Session, Ability, Alert, $http) {

    $http.get('/api/users').success(function(response) {
      $scope.user = response.user;
    });

    $scope.changePassword = function(user) {

      $http.put('/api/users/change_password', {
          password: user.password,
          password_confirmation: user.password_confirmation
        })
        .success(function(data, status, headers, config) {
          Alert.add("success", data.msg, 2000);
          $location.path( "/users/login" );
          return true
        })
        .error(function(data, status, headers, config) {
          Alert.add("danger", 'sorry, something went wrong', 4000);
        });

    }


  });
