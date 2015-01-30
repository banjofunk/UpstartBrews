angular.module('AngularUpstart')
  .controller('BatchesCtrl', function ($scope, $http, Ability, Alert, $timeout) {
    $scope.errors = [];
    $scope.selected_batch = {};
    $http.get('/api/batches.json')
      .success(function(data, status, headers, config) {
        $scope.batches = data;
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

    $scope.showModal = false;
    $scope.toggleModal = function(batch){
      $scope.details_category = "";
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
          index = $scope.batches.indexOf(batch)
          $scope.batches[index] = data
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
          index = $scope.batches.indexOf(batch)
          $scope.batches[index].fermenter = data
          return true
        }).
        error(function(data, status, headers, config) {
          Alert.add("error", 'sorry, you are not authorized to re-order the tanks', 4000);
        });
    }


  })
  .controller('BatchCtrl', function ($scope, $routeParams, $http) {
    var batchId = $routeParams.batchId
    var url = '/api/batches/' + batchId + '.json';
    $http.get(url).
      success(function(data, status, headers, config) {
        $scope.batch = data;
      })

  });
