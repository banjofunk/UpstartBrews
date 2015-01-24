angular.module('AngularUpstart')
  .controller('FermentationCtrl', function ($scope, $http, Ability, Alert) {

    $scope.$watch('details_category', function(newValue, oldValue) {
      if(newValue == "fermentation"){
        $http.get('/api/batches/' + $scope.selected_batch.id + '/batch_processes')
          .success(function(data, status, headers, config) {
            $scope.selected_batch.batch_processes = data.batch_processes;
            $scope.selected_batch.all_processes = data.all_processes;
          })
      }
    });

    $scope.startProcess = function(batchId, processType) {
      $http.post('/api/batches/' + batchId + '/batch_processes/start_batch_process', { batch_id: batchId, process_type: processType }).
        success(function(data, status, headers, config) {
          $scope.$parent.selected_batch.all_processes[data.type] = true
          $scope.$parent.selected_batch.batch_processes.push(data)
        }).
        error(function(data, status, headers, config) {
          Alert.add("error", 'sorry, you are not authorized to start fermentation processes', 4000);
        });
    }

    $scope.stopProcess = function(process) {
      $http.post('/api/batches/' + $scope.selected_batch.id + '/batch_processes/end_batch_process', { kind: process }).
        success(function(data, status, headers, config) {
          $scope.$parent.selected_batch.all_processes[data.type] = false
          var processes = $scope.selected_batch.batch_processes
          for(var i = 0, len = processes.length; i < len; i++) {
            if (processes[i].id === data.id) {
              $scope.selected_batch.batch_processes[i] = data
              break;
            }
          }
        }).
        error(function(data, status, headers, config) {
          Alert.add("error", 'sorry, you are not authorized to start fermentation processes', 4000);
        });
    }

    $scope.removeProcess = function(process){
      $http.delete('/api/batches/' + process.batch_id + '/batch_processes/' + process.id, {}).
        success(function(data, status, headers, config) {
          var index = $scope.selected_batch.batch_processes.indexOf(process)
          $scope.selected_batch.batch_processes.splice(index, 1)
        }).
        error(function(data, status, headers, config) {
          Alert.add("error", 'sorry, you are not authorized to delete readings', 4000);
        });
    }

    $scope.showEdit = true;
    $scope.editProcess = function(process){
      $http.put('/api/batches/' + process.batch_id + '/batch_processes/' + process.id, {
        batch_id: process.batch_id,
        process_id: process.id,
        process_type: process.kind,
        started: process.started,
        stopped: process.stopped
      })
        .success(function(data, status, headers, config) {
          var index = $scope.selected_batch.batch_processes.indexOf(process)
          $scope.selected_batch.batch_processes[index] = data
          return true
        })
        .error(function(data, status, headers, config) {
          Alert.add("error", 'sorry, you are not authorized to edit processes', 4000);
        });
    }

  });
