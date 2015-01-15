angular
  .module('AngularUpstart', [
    'ngRoute',
    'templates',
    'AngularUpstart.directives',
    'sessionService',
    'recordService'
  ])
  .config(function ($routeProvider, $locationProvider) {
    $routeProvider
      .when('/', { templateUrl: 'batches.html', controller: 'BatchesCtrl' })
      .when('/batches', { templateUrl: 'batches.html', controller: 'BatchesCtrl' })
      .when('/batches/:batchId', { templateUrl: 'batch.html', controller: 'BatchCtrl' })
      .when('/record', {templateUrl:'record/index.html', controller:'RecordCtrl'})
      .when('/users/login', {templateUrl:'users/login.html', controller:'UsersCtrl'})
      .when('/users/register', {templateUrl:'users/register.html', controller:'UsersCtrl'})
      .otherwise({ redirectTo: '/batches' });
    $locationProvider.html5Mode(true);
  })
  .config(['$httpProvider', function($httpProvider){
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
    $httpProvider.interceptors.push(function ($q, $location) {
      return {
        'response': function (response) {
          return response;
        },
        'responseError': function (response) {
            if(response.status === 403) {
              $location.path('/users/login');
              return response
            }
            return $q.reject(response);
        }
      };
    });
  }]);