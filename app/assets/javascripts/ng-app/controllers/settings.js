angular.module('AngularUpstart')
  .controller('SettingsCtrl', ['$scope', '$location', 'Session', 'Ability', 'Alert', '$http', function($scope, $location, Session, Ability, Alert, $http) {

    $http.get('/api/users').success(function(response) {
      $scope.user = response.user;
      if(!$scope.user){ $location.path( "/users/login" );}
    });

    $scope.changePassword = function(user) {

      $http.put('/api/users/change_password', {
          user: {
            password: user.password,
            password_confirmation: user.password_confirmation
          }
        })
        .success(function(data, status, headers, config) {
          Alert.add("success", data.msg, 2000);
          $scope.user = {}
          return true
        })
        .error(function(data, status, headers, config) {
          Alert.add("danger", 'sorry, something went wrong', 4000);
        });

    }


  }]);
