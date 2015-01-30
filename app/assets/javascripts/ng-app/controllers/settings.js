angular.module('AngularUpstart')
  .controller('SettingsCtrl', function ($scope, $location, Session, Ability, $http, Alert) {

    $scope.$watch('details_category', function(newValue, oldValue) {
      if(newValue == "settings"){
        console.log('settings controller')
      }
    });

  });
