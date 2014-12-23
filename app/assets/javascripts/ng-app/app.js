angular
  .module('AngularUpstart', [
    'ngRoute',
    'templates'
  ]).config(function ($routeProvider, $locationProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'brewery.html',
        controller: 'BreweryCtrl'
      });
    $locationProvider.html5Mode(true);
  });