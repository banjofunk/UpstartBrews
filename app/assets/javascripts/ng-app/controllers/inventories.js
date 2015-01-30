angular.module('AngularUpstart')
  .controller('InventoriesCtrl', function ($scope, $http, Ability, Alert, $timeout) {
    $scope.update_queue = [];

    $scope.$watch('details_category', function(newValue, oldValue) {
      if(newValue == "inventory"){
        $http.get('/api/inventories', {params: {batch_id: $scope.selected_batch.id}})
          .success(function(data, status, headers, config) {
            $scope.selected_batch.inventories = data;
          })
      }
    });

    var timeout = null;
    var saveUpdates = function() {
      inventoryIds = $scope.update_queue.reduce(function(p, c) {
        if (p.indexOf(c) < 0) p.push(c);
        return p;
      }, []);
      $scope.update_queue = [];

      for (var i = 0; i < inventoryIds.length; i++) {
        var id = inventoryIds[i]
        var inventory = $scope.selected_batch.inventories.filter(function( obj ) {
          return obj.id == id;
        });
        inventory = inventory[0]

        $http.put('/api/inventories/' + inventory.id + '/update_quantity', {
          quantity: inventory.quantity
        }).
          success(function(data, status, headers, config) {
            return true
          }).
          error(function(data, status, headers, config) {
            Alert.add("danger", 'sorry, you are not authorized to edit readings', 4000);
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

    $scope.increaseQty = function(inventory) {
      inventory.quantity += 1;
      $scope.update_queue.push(inventory.id)
    }

    $scope.decreaseQty = function(inventory) {
      inventory.quantity -= 1;
      $scope.update_queue.push(inventory.id)
    }

    $scope.editQty = function(inventory) {
      if(!inventory.quantity) {
        inventory.quantity = 0
      }
      $scope.update_queue.push(inventory.id)
    }

    $scope.setInventories = function() {
      id = $scope.selected_batch.id
    $http.put('/api/batches/' + id + '/set_inventories', {})
      .success(function(data, status, headers, config) {
        $scope.selected_batch.inventory_set = data.inventory_set
        return true
      })
      .error(function(data, status, headers, config) {
        Alert.add("danger", 'sorry, you are not authorized to set inventories', 4000);
      });

    }

    $scope.$watch('update_queue.length', debounceSaveUpdates)

  });