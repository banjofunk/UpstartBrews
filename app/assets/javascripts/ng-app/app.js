angular
  .module('AngularUpstart', [
    'ngRoute',
    'templates'
  ]).config(function ($routeProvider, $locationProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'brewery.html',
        controller: 'BreweryCtrl'
      })
      .when('/batches', {
        templateUrl: 'brewery.html',
        controller: 'BatchCtrl'
      });
    $locationProvider.html5Mode(true);
  });