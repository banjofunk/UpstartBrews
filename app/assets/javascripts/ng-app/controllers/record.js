angular.module('AngularUpstart')
  .controller('RecordCtrl', function ($scope, $http, Session, Records) { "use strict";

    $http.get('/api/users').success(function(response) {
      $scope.user = response.user;
    });
    $scope.records = Records.index();

    $scope.logout = function() {
      Session.logout();
    };
  });

