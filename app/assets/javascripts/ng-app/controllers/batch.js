angular.module('AngularUpstart')
  .controller('BatchCtrl', ['$scope', '$routeParams', '$http', function ($scope, $routeParams, $http) {
    var batchId = $routeParams.batchId
    var url = '/api/batches/' + batchId + '.json';
    $http.get(url).
      success(function(data, status, headers, config) {
        debugger
        $scope.selected_batch = data;
      })

  }]);