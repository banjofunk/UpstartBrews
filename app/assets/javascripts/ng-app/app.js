angular
  .module('AngularUpstart', [
    'ngRoute',
    'templates',
    'AngularUpstart.directives'
  ]).config(function ($routeProvider, $locationProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'batches.html',
        controller: 'BreweryCtrl'
      })
      .when('/batches', {
        templateUrl: 'batches.html',
        controller: 'BatchesCtrl'
      })
      .when('/batches/:batchId', {
        templateUrl: 'batch.html',
        controller: 'BatchCtrl'
      });
    $locationProvider.html5Mode(true);
  });