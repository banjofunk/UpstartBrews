angular.module('AngularUpstart')
  .controller('OverviewsCtrl', function ($scope, $location, Session, Ability, $http, Alert) {

    $scope.$watch('details_category', function(newValue, oldValue) {
      if(newValue == "overview"){
        console.log('overview controller')
      }
    });

  });
