angular.module('AngularUpstart')
  .controller('BatchCtrl', ['$scope', '$routeParams', '$http', function ($scope, $routeParams, $http) {
    var batchId = $routeParams.batchId
    var url = '/api/batches/' + batchId + '.json';
    $http.get(url).
      success(function(data, status, headers, config) {
        $scope.selected_batch = data;
        debugger
        $scope.selected_batch.fermentation_processes = data.batch_processes;
        $scope.selected_batch.all_fermentation_processes = data.all_processes.fermentation;
        $scope.selected_batch.all_bottle_processes = data.all_processes.bottling;
        $scope.selected_batch.all_carbonation_processes = data.all_processes.carbonation;
      })

  }]);