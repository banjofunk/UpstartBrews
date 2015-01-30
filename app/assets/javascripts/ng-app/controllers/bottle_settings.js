angular.module('AngularUpstart')
  .controller('BottleSettingsCtrl', function ($scope, $location, Session, Ability, $http, Alert, $timeout) {

    $scope.$watch('details_category', function(newValue, oldValue) {
      if(newValue == "bottle_settings"){
        $http.get('/api/batches/' + $scope.selected_batch.id + '/batch_bottle_settings')
          .success(function(data, status, headers, config) {
            $scope.selected_batch.bottle_settings = data;
          })
        $http.get('/api/batches/' + $scope.selected_batch.id + '/batch_processes', {params: {category: 'bottling'}})
          .success(function(data, status, headers, config) {
            $scope.selected_batch.bottle_processes = data.batch_processes;
            $scope.selected_batch.all_bottle_processes = data.all_processes;
            $scope.$broadcast('setProcessType', 'bottle');
          })

      }
    });

    $scope.update_queue = [];
    var timeout = null;
    var saveUpdates = function() {
      bottle_settingIds = $scope.update_queue.reduce(function(p, c) {
        if (p.indexOf(c) < 0) p.push(c);
        return p;
      }, []);
      $scope.update_queue = [];

      for (var i = 0; i < bottle_settingIds.length; i++) {
        var id = bottle_settingIds[i]
        var bottle_setting = $scope.selected_batch.bottle_settings.filter(function( obj ) {
          return obj.id == id;
        });
        bottle_setting = bottle_setting[0]

        $http.put(' /api/batches/' + $scope.selected_batch.id + '/batch_bottle_settings/' + bottle_setting.id + '/update_quantity', {
          quantity: bottle_setting.quantity,
          batch_id: $scope.selected_batch.id,
          kind: bottle_setting.kind.id
        }).
          success(function(data, status, headers, config) {
            return true
          }).
          error(function(data, status, headers, config) {
            Alert.add("danger", 'sorry, you are not authorized to edit bottle settings', 4000);
          });

      };
    };

    var debounceSaveUpdates = function(newVal, oldVal) {
      if (newVal != oldVal) {
        if (timeout) {
          $timeout.cancel(timeout)
        }
        timeout = $timeout(saveUpdates, 1000);
      }
    };

    $scope.increaseQty = function(bottle_setting) {
      bottle_setting.quantity += 1;
      $scope.update_queue.push(bottle_setting.id)
    }

    $scope.decreaseQty = function(bottle_setting) {
      bottle_setting.quantity -= 1;
      $scope.update_queue.push(bottle_setting.id)
    }

    $scope.editQty = function(bottle_setting) {
      if(!bottle_setting.quantity) {
        bottle_setting.quantity = 0
      }
      $scope.update_queue.push(bottle_setting.id)
    }

    $scope.$watch('update_queue.length', debounceSaveUpdates)

  });
