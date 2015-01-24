angular.module('AngularUpstart')
  .controller('InventoriesCtrl', function ($scope, $http, Ability, Alert) {

    $scope.$watch('details_category', function(newValue, oldValue) {
      if(newValue == "packaging"){
        $http.get('/api/inventories', {params: {batch_id: $scope.selected_batch.id}})
          .success(function(data, status, headers, config) {
            $scope.selected_batch.inventories = data.inventories;
            $scope.selected_batch.package_types = data.package_types;
          })
      }
    });

  });