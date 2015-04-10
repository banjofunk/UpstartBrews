angular.module('AngularUpstart')
  .controller('ProcessesCtrl', ['$scope', '$http', 'Ability', 'Alert', function($scope, $http, Ability, Alert) {

    $scope.startProcess = function(process) {
      $http.post('/api/batches/' + $scope.selected_batch.id + '/batch_processes/start_batch_process', { batch_id: $scope.selected_batch.id, process_type: process.name }).
        success(function(data, status, headers, config) {
          // var all_proc = $scope.selected_batch[all_processes]
          var all_proc = $scope.selected_batch.all_processes[process.category]
          for(var i = 0, len = all_proc.length; i < len; i++) {
            if (all_proc[i].name === data.type) {
              all_proc[i].currently_on = true
              break;
            }
          }
          $scope.selected_batch.current_processes[process.category].push(data)
        }).
        error(function(data, status, headers, config) {
          Alert.add("danger", 'sorry, you are not authorized to start ' + $scope.process_type + ' processes', 4000);
        });
    }

    $scope.stopProcess = function(process) {
      debugger
      $http.post('/api/batches/' + $scope.selected_batch.id + '/batch_processes/end_batch_process', { kind: process.name }).
        success(function(data, status, headers, config) {
          var all_proc = $scope.selected_batch.all_processes[process.category]
          for(var i = 0, len = all_proc.length; i < len; i++) {
            if (all_proc[i].name === data.type) {
              all_proc[i].currently_on = false
              break;
            }
          }
          var processes = $scope.selected_batch.current_processes[process.category]
          for(var i = 0, len = processes.length; i < len; i++) {
            if (processes[i].id === data.id) {
              $scope.selected_batch.current_processes[process.category][i] = data
              break;
            }
          }
        }).
        error(function(data, status, headers, config) {
          Alert.add("danger", 'sorry, you are not authorized to start ' + $scope.process_type + ' processes', 4000);
        });
    }

    $scope.removeProcess = function(process){
      $http.delete('/api/batches/' + process.batch_id + '/batch_processes/' + process.id, {}).
        success(function(data, status, headers, config) {
          var all_proc = $scope.selected_batch.all_processes[process.category]
          for(var i = 0, len = all_proc.length; i < len; i++) {
            if (all_proc[i].name === process.type) {
              all_proc[i].currently_on = data
              break;
            }
          }
          var index = $scope.selected_batch.current_processes[process.category].indexOf(process)
          $scope.selected_batch.current_processes[process.category].splice(index, 1)
        }).
        error(function(data, status, headers, config) {
          Alert.add("danger", 'sorry, you are not authorized to delete readings', 4000);
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
          var index = $scope.selected_batch.current_processes[process.category].indexOf(process)
          $scope.selected_batch.current_processes[process.category][index] = data
          return true
        })
        .error(function(data, status, headers, config) {
          Alert.add("danger", 'sorry, you are not authorized to edit processes', 4000);
        });
    }

  }]);
