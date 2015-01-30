angular.module('AngularUpstart')
  .controller('FermentationCtrl', function ($scope, $http, Ability, Alert) {

    $scope.$watch('details_category', function(newValue, oldValue) {
      if(newValue == "fermentation"){
        $http.get('/api/batches/' + $scope.selected_batch.id + '/batch_processes', {params: {category: 'fermentation'}})
          .success(function(data, status, headers, config) {
            $scope.$broadcast('setProcessType', 'fermentation');
            $scope.selected_batch.fermentation_processes = data.batch_processes;
            $scope.selected_batch.all_fermentation_processes = data.all_processes;
          })
      }
    });

  });
