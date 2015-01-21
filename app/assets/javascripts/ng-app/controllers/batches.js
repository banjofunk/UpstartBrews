angular.module('AngularUpstart')
  .controller('BatchesCtrl', function ($scope, $http, Ability, $rootScope) {
    $scope.selected_batch = {};
    $scope.details_category = "readings";
    $http.get('/api/batches.json')
      .success(function(data, status, headers, config) {
        $scope.batches = data;
      })

    $scope.canCan = function(action, subject){
      return Ability.canCan(action, subject)
    }

    $scope.showModal = false;
    $scope.toggleModal = function(batchId){
      $http.get('/api/batches/' + batchId + '.json').
        success(function(data, status, headers, config) {
          $scope.selected_batch = data;
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
          alert('there was an error');
        });
    }

    $scope.detailsNav = function(category) {
      $scope.details_category = category
    }

    $scope.newReading = function(reading){
      $http.post('/api/batch_readings', {
        ph: reading.ph,
        brix: reading.brix,
        temp: reading.temp,
        batch_id: $scope.selected_batch.id
      }).
        success(function(data, status, headers, config) {
          $('.new_reading').val('');
          $scope.selected_batch.batch_readings.push(data)
        }).
        error(function(data, status, headers, config) {
          alert('there was an error');
        });
    }

    $scope.showEdit = true;
    $scope.editReading = function(reading) {
      $http.put('/api/batch_readings/' + reading.id, {
        ph: reading.ph,
        brix: reading.brix,
        temp: reading.temp,
        reading_date: reading.reading_date
      }).
        success(function(data, status, headers, config) {
          return true
        }).
        error(function(data, status, headers, config) {
          alert('there was an error');
        });

    }

    $scope.removeReading = function(reading_id){
      $http.delete('/api/batch_readings/' + reading_id, {}).
        success(function(data, status, headers, config) {
          $scope.selected_batch.batch_readings.pop(data)
        }).
        error(function(data, status, headers, config) {
          alert('there was an error');
        });
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
