angular.module('AngularUpstart')
  .controller('AdminCtrl', function ($scope, Session, $http, Ability, Alert) {
    $scope.errors = [];
    $http.get('/api/admin/users.json')
      .success(function(data, status, headers, config) {
        $scope.users = data.users;
        $scope.all_roles = data.all_roles;
      })

    $scope.hasRole = function(role){
      return Ability.hasRole(role)
    };

    $scope.updateRoles = function(user, $event) {
      var index = user.roles.indexOf($event.target.name);
      if (index == -1){
        user.roles.push($event.target.name)
      } else {
        user.roles.splice(index, 1)
      }

      $http.put('api/admin/users', { user: user }).
        success(function(data, status, headers, config) {
          return true
        }).
        error(function(data, status, headers, config) {
          Alert.add("error", 'sorry, you are not authorized to update user roles', 4000);
        });

    }

    $scope.deleteUser = function(user) {

      $http.delete('api/admin/users/' + user.id).
        success(function(data, status, headers, config) {
          var index = $scope.users.indexOf(user);
          $scope.users.splice(index, 1)
          return true
        }).
        error(function(data, status, headers, config) {
          Alert.add("error", 'sorry, you are not authorized to delete users', 4000);
        });
    }

  });

