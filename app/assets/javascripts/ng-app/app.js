angular
  .module('AngularUpstart', [
    'ngRoute',
    'templates',
    'AngularUpstart.directives',
    'sessionService',
    'abilityService',
    'alertService'
  ])
  .config(function ($routeProvider, $locationProvider) {
    $routeProvider
      .when('/', { templateUrl: 'batches/batches.html', controller: 'BatchesCtrl' })
      .when('/batches', { templateUrl: 'batches/batches.html', controller: 'BatchesCtrl' })
      .when('/batches/:batchId', { templateUrl: 'batches/batch.html', controller: 'BatchCtrl' })
      .when('/users/login', {templateUrl:'users/login.html', controller:'UsersCtrl'})
      .when('/users/register', {templateUrl:'users/register.html', controller:'UsersCtrl'})
      .when('/admin', {templateUrl:'admin/admin.html', controller:'AdminCtrl'})
      .otherwise({ redirectTo: '/' });
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
              return $q.reject(response);
            }
            if(response.status === 500 && response.data.error == "You are not authorized to access this page.") {
              $location.path('/');
              return response
            }
            return $q.reject(response);
        }
      };
    });
  }])
  .controller('AppCtrl', function($scope,$route,$location, Ability){
    $scope.$on("authLoginSuccess",function(){
      Ability.currentAbility = null;
      Ability.currentRoles = null;
      Ability.requestCurrentAbility();
    });

    $scope.canCan = function(action, subject){
      return Ability.canCan(action, subject)
    }

    $scope.hasRole = function(role){
      return Ability.hasRole(role)
    };
  })