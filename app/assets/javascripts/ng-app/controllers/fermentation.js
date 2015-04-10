angular.module('AngularUpstart')
  .controller('FermentationCtrl', ['$scope', '$http', 'Ability', 'Alert', function($scope, $http, Ability, Alert) {

    $scope.$watch('details_category', function(newValue, oldValue) {
      if(newValue == "fermentation"){
        $http.get('/api/batches/' + $scope.selected_batch.id + '/batch_processes')
          .success(function(data, status, headers, config) {
            $scope.selected_batch.current_processes = data.current_processes
            $scope.selected_batch.all_processes = data.all_processes
          })
      }
    });

  }]);
