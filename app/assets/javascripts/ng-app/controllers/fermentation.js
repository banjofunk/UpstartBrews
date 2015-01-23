angular.module('AngularUpstart')
  .controller('FermentationCtrl', function ($scope, $http, Ability, Alert) {

    $scope.startProcess = function(batchId, processType) {
      $http.post('/api/batches/' + batchId + '/batch_processes/start_batch_process', { batch_id: batchId, process_type: processType }).
        success(function(data, status, headers, config) {
          $scope.$parent.selected_batch[data.type + '_on'] = true
          $scope.$parent.selected_batch[data.type].push(data)
        }).
        error(function(data, status, headers, config) {
          Alert.add("error", 'sorry, you are not authorized to start fermentation processes', 4000);
        });
    }

    $scope.stopProcess = function(process) {
      $http.post('/api/batches/' + process.batch_id + '/batch_processes/end_batch_process', { batch_id: process.batch_id, process_id: process.id, kind: process.type }).
        success(function(data, status, headers, config) {
          $scope.$parent.selected_batch[data.type + '_on'] = false
          $scope.$parent.selected_batch[data.type].pop(process)
          $scope.$parent.selected_batch[data.type].push(data)
        }).
        error(function(data, status, headers, config) {
          Alert.add("error", 'sorry, you are not authorized to start fermentation processes', 4000);
        });
    }

    $scope.removeProcess = function(process){
      $http.delete('/api/batches/' + process.batch_id + '/batch_processes/' + process.id, {}).
        success(function(data, status, headers, config) {
          var index = $scope.selected_batch[process.type].indexOf(process)
          $scope.selected_batch[process.type].splice(index, 1)
        }).
        error(function(data, status, headers, config) {
          Alert.add("error", 'sorry, you are not authorized to delete readings', 4000);
        });
    }

    $scope.showEdit = true;
    $scope.editProcess = function(process){
      $http.put('/api/batches/' + process.batch_id + '/batch_processes/' + process.id, {
        batch_id: process.batch_id,
        process_type: process.kind,
        started: process.started,
        stopped: process.stopped
      })
        .success(function(data, status, headers, config) {
          var index = $scope.selected_batch[process.type].indexOf(process)
          $scope.selected_batch[process.type][index] = data
          return true
        })
        .error(function(data, status, headers, config) {
          Alert.add("error", 'sorry, you are not authorized to edit processes', 4000);
        });
    }

  });
