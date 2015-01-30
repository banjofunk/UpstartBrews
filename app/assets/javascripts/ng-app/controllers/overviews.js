angular.module('AngularUpstart')
  .controller('OverviewsCtrl', function ($scope, $location, Session, Ability, $http, Alert) {

    $scope.$watch('details_category', function(newValue, oldValue) {
      if(newValue == "overview"){
        $http.get('/api/flavors')
          .success(function(data, status, headers, config) {
            $scope.flavor_id = $scope.selected_batch.flavor.id
            $scope.flavors = data;
          })
      }
    });

    $scope.updateFlavor = function() {
      $http.put('/api/batches/' + $scope.selected_batch.id, {
        flavor_id: $scope.flavor_id
      }).
        success(function(data, status, headers, config) {
          $scope.selected_batch.flavor = data.flavor
          return true
        }).
        error(function(data, status, headers, config) {
          Alert.add("danger", 'sorry, you are not authorized to edit batches', 4000);
        });
    }

    $scope.updateBrewDate = function() {
      $http.put('/api/batches/' + $scope.selected_batch.id, {
        brew_date: $scope.selected_batch.brew_date
      }).
        success(function(data, status, headers, config) {
          $scope.selected_batch.brew_date = data.brew_date
          $scope.selected_batch.days_ago = data.days_ago
          return true
        }).
        error(function(data, status, headers, config) {
          Alert.add("danger", 'sorry, you are not authorized to edit batches', 4000);
        });

    }


  });
