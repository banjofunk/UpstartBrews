angular.module('AngularUpstart')
  .controller('FermentationCtrl', function ($scope, $http, Ability, Alert) {

    $scope.startProcess = function(batchId, process) {
      $http.post('/api/batches/' + batchId + '/start_process', { process: process }).
        success(function(data, status, headers, config) {
          debugger
          return true
        }).
        error(function(data, status, headers, config) {
          Alert.add("error", 'sorry, you are not authorized to start fermentation processes', 4000);
        });
    }

    $scope.stopProcess = function(process) {
      debugger
    }


  });
