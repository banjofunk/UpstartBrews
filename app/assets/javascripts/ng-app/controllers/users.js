angular.module('AngularUpstart')
  .controller('UsersCtrl', function ($scope, Session, Ability, Alert) {
    $scope.login = function(user) {
        $scope.authError = null;

        Session.login(user.email, user.password)
        .success(function(response) {
          if(response.error) {
            Alert.add('danger', response.error, 4000)
            return response
          }
        })
        .error(function(response) {
            Alert.add('danger', (response.error || 'Server offline, please try later'), 4000);
        });
    };

    $scope.logout = function() {
      Session.logout();
    };

});

