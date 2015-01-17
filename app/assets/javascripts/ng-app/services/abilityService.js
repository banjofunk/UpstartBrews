angular.module('abilityService', [])
  .factory('Ability', function($http) {

      var service = {
        canCan: function(action, subject) {
          if(service.currentAbility){
            return service.currentAbility[action][subject] || false
          }else{
            return false
          }
        },
        requestCurrentAbility: function() {
          if (!!service.currentAbility) {
            return $q.when(service.currentAbility);
          } else {
            return $http.get('/api/users/ability.json').then(function(response) {
              service.currentAbility = response.data;
              return service.currentAbility;
            });
          }
        },
        currentAbility: null
      };
      service.requestCurrentAbility();
      return service;
  })