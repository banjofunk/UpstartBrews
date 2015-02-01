angular.module('AngularUpstart')
  .controller('navCtrl', function ($scope, $location, Session, Ability, $http) {

    $http.get('/api/users').success(function(response) {
      $scope.user = response.user;
    });

    $scope.logout = function() {
      Session.logout('/users/login');
    }

    $scope.hasRole = function(role){
      return Ability.hasRole(role)
    };
  });
