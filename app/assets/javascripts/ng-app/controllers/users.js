angular.module('AngularUpstart')
  .controller('UsersCtrl', function ($scope, Session, Ability) {
    $scope.login = function(user) {
        $scope.authError = null;

        Session.login(user.email, user.password)
        .success(function(response) {
            if (!response) {
                $scope.authError = 'Credentials are not valid';
            } else {
                $scope.authError = 'Success!';
            }
        })
        .error(function(response) {
            $scope.authError = response.data.error || 'Server offline, please try later';
        });
    };

    $scope.logout = function() {
      Session.logout();
    };

    $scope.register = function(user) {
        $scope.authError = null;

        Session.register(user.first_name, user.last_name, user.email, user.password, user.confirm_password)
            .then(function(response) {
            }, function(response) {
                var errors = '';
                $.each(response.data.errors, function(index, value) {
                    errors += index.substr(0,1).toUpperCase()+index.substr(1) + ' ' + value + ''
                });
                $scope.authError = errors;
            });
    };
});

