angular.module('abilityService', [])
  .factory('Ability', function($http) {
      var service = {
        canCan: function(action, subject) {
          if(service.currentAbility){
            var can, ability;
            ability = service.currentAbility
            if (ability['manage']['all'] || ability['manage'][subject] || ability[action]['all'] ) {
              can = true
            } else {
              can = ability[action][subject] || false
            }
            return can
          }else{
            return false
          }
        },
        hasRole: function(role) {
          if(service.currentRoles){
            var can, ability;
            roles = service.currentRoles
            if ((roles.indexOf(role) != -1) || (roles.indexOf('admin') != -1) ) {
              hasRole = true
            } else {
              hasRole = false
            }
            return hasRole
          }else{
            return false
          }
        },
        requestCurrentAbility: function() {
          if (!!service.currentAbility) {
            return $q.when(service.currentAbility);
          } else {
            return $http.get('/api/users/ability.json').then(function(response) {
              service.currentAbility = response.data.ability;
              service.currentRoles = response.data.roles;
              return service.currentAbility;
            });
          }
        },
        currentAbility: null,
        currentRoles: null
      };
      service.requestCurrentAbility();
      return service;
  })