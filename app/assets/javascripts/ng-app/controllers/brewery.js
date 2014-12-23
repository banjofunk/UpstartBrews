angular.module('AngularUpstart')
  .controller('BreweryCtrl', function ($scope, $http) {

    $http.get('/batches.json').
      success(function(data, status, headers, config) {
        $scope.batches = data;
      })
  });
