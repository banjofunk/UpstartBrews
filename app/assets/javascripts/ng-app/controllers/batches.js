angular.module('AngularUpstart')
  .controller('BatchesCtrl', ['$scope', '$http', 'Ability', 'Alert', '$timeout', function ($scope, $http, Ability, Alert, $timeout) {
    $scope.errors = [];
    $scope.selected_batch = {};
    $http.get('/api/batches')
      .success(function(data, status, headers, config) {
        $scope.batches = data.fermenting;
        $scope.bottling_batches = data.bottling;
        $scope.sort = $scope.batches.map(function(batch){ return batch.fermenter.id; });
      })

    $http.get('/api/flavors')
      .success(function(data, status, headers, config) {
        $scope.flavors = data;
      })

    $scope.isFull = function(fermenter) {
      return fermenter.state=="full"
    }

    $scope.isClean = function(fermenter) {
      return fermenter.state=="clean"
    }

    $scope.fermenterOrder = function(batch) {
      return $scope.sort.indexOf(batch.fermenter.id)
    }

    $scope.showModal = false;
    $scope.toggleModal = function(batch){
      $http.get('/api/batches/' + batch.id + '.json').
        success(function(data, status, headers, config) {
          $scope.selected_batch = data;
          var batches = $scope.batches
          for(var i = 0, len = batches.length; i < len; i++) {
            if (batches[i].id === data.id) {
              batches[i] = $scope.selected_batch
              break;
            }
          }
          $scope.details_category = "overview";
        })
      $scope.showModal = !$scope.showModal;
    };
    $scope.hideModal = function() {
      $scope.showModal = false;
    }

    $scope.postSort = function(sort){
      $http.post('/api/fermenters/sort', { sort: sort }).
        success(function(data, status, headers, config) {
          $scope.sort = data
          return true
        }).
        error(function(data, status, headers, config) {
          Alert.add("error", 'sorry, you are not authorized to re-order the tanks', 4000);
        });
    }

    $scope.addBatch = function(flavor, batch){
      $http.post('/api/batches', {
          fermenter_id: batch.fermenter.id,
          flavor_id: flavor.id
        }).
        success(function(data, status, headers, config) {

          var batches = $scope.batches
          for(var i = 0, len = batches.length; i < len; i++) {
            if (batches[i].fermenter.id === batch.fermenter.id) {
              batches[i] = data
              break;
            }
          }

          return true
        }).
        error(function(data, status, headers, config) {
          Alert.add("error", 'sorry, you are not authorized to re-order the tanks', 4000);
        });
    }

    $scope.detailsNav = function(category) {
      $scope.details_category = category
    }

    $scope.changeFermenterState = function(batch, state) {
      $http.post('/api/fermenters/' + batch.fermenter.id + '/set_fermenter_state', {id: batch.fermenter.id, state_name: state}).
        success(function(data, status, headers, config) {

          var batches = $scope.batches
          for(var i = 0, len = batches.length; i < len; i++) {
            if (batches[i].fermenter.id === batch.fermenter.id) {
              batch.fermenter = data
              $scope.batches[i] = batch
              break;
            }
          }
          return true
        }).
        error(function(data, status, headers, config) {
          Alert.add("error", 'sorry, you are not authorized to re-order the tanks', 4000);
        });
    }

    $scope.changeBatchState = function(batch, state) {
      $http.post('/api/batches/' + batch.id + '/set_batch_state', {id: batch.id, state: state}).
        success(function(data, status, headers, config) {
          index = $scope.batches.indexOf(batch)
          $scope.batches[index] = data
          $scope.showModal = false
          return true
        }).
        error(function(data, status, headers, config) {
          Alert.add("error", 'sorry, you are not authorized to re-order the tanks', 4000);
        });

    }


  }])
  .controller('BatchCtrl', function ($scope, $routeParams, $http) {
    var batchId = $routeParams.batchId
    var url = '/api/batches/' + batchId + '.json';
    $http.get(url).
      success(function(data, status, headers, config) {
        $scope.batch = data;
      })

  });
