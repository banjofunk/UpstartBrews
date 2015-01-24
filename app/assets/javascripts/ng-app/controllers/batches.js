angular.module('AngularUpstart')
  .controller('BatchesCtrl', function ($scope, $http, Ability, Alert, $timeout) {
    $scope.errors = [];
    $scope.selected_batch = {};
    $http.get('/api/batches.json')
      .success(function(data, status, headers, config) {
        $scope.batches = data;
      })

    $scope.showModal = false;
    $scope.toggleModal = function(batchId){
      $scope.details_category = "";
      $http.get('/api/batches/' + batchId + '.json').
        success(function(data, status, headers, config) {
          $scope.selected_batch = data;
          $scope.details_category = "packaging";
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

    $scope.detailsNav = function(category) {
      $scope.details_category = category
    }

    $scope.addBatch = function(){
      debugger
      // $scope.batches.push({"id":1,"flavor":"lemon poop","created_at":"2014-12-17","batch_readings":[{"id":1,"reading_date":"2014-12-17","ph":0.0,"brix":10.0,"temp":10.0},{"id":2,"reading_date":"2014-12-16","ph":1.1,"brix":21.1,"temp":21.1},{"id":3,"reading_date":"2014-12-15","ph":2.2,"brix":32.2,"temp":32.2},{"id":4,"reading_date":"2014-12-14","ph":3.3,"brix":43.3,"temp":43.3},{"id":5,"reading_date":"2014-12-13","ph":4.4,"brix":54.4,"temp":54.4}]})
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
