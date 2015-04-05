angular.module('AngularUpstart')
  .controller('CarbonationSettingsCtrl', ['$scope', '$location', 'Session', 'Ability', '$http', 'Alert', '$timeout', function($scope, $location, Session, Ability, $http, Alert, $timeout) {

    $scope.$watch('details_category', function(newValue, oldValue) {
      if(newValue == "carb_settings"){
        $http.get('/api/batches/' + $scope.selected_batch.id + '/batch_carbonation_settings')
          .success(function(data, status, headers, config) {
            $scope.selected_batch.carbonation_settings = data;
          })
        $http.get('/api/batches/' + $scope.selected_batch.id + '/batch_processes', {params: {category: 'carbonation'}})
          .success(function(data, status, headers, config) {
            $scope.selected_batch.carbonation_processes = data.batch_processes;
            $scope.selected_batch.all_carbonation_processes = data.all_processes.carbonation;
            $scope.$broadcast('setProcessType', 'carbonation');
          })
      }
    });

    $scope.update_queue = [];
    var timeout = null;
    var saveUpdates = function() {
      var carbonationSettingNamesArray = $scope.update_queue.reduce(function(p, c) {
        if (p.indexOf(c) < 0) p.push(c);
        return p;
      }, []);
      $scope.update_queue = [];
      for (var i = 0; i < carbonationSettingNamesArray.length; i++) {
        var short_name = carbonationSettingNamesArray[i]
        var carbonation_setting = $scope.selected_batch.carbonation_settings.filter(function( obj ) {
          return obj.kind.short_name == short_name;
        });
        carbonation_setting = carbonation_setting[0]
        $http.put(' /api/batches/' + $scope.selected_batch.id + '/batch_carbonation_settings/update_quantity', {
          quantity: carbonation_setting.quantity,
          batch_id: $scope.selected_batch.id,
          kind: carbonation_setting.kind.id
        }).
          success(function(data, status, headers, config) {
            return true
          }).
          error(function(data, status, headers, config) {
            Alert.add("danger", 'sorry, you are not authorized to edit carbonation settings', 4000);
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

    $scope.increaseQty = function(carbonation_setting) {
      carbonation_setting.quantity += 1;
      $scope.update_queue.push(carbonation_setting.kind.short_name)
    }

    $scope.decreaseQty = function(carbonation_setting) {
      carbonation_setting.quantity -= 1;
      $scope.update_queue.push(carbonation_setting.kind.short_name)
    }

    $scope.editQty = function(carbonation_setting) {
      if(!carbonation_setting.quantity) {
        carbonation_setting.quantity = 0
      }
      $scope.update_queue.push(carbonation_setting.kind.short_name)
    }

    $scope.$watch('update_queue.length', debounceSaveUpdates)

  }]);
