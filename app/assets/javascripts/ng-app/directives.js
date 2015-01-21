/*
 jQuery UI Sortable plugin wrapper
 @param [ui-sortable] {object} Options to pass to $.fn.sortable() merged onto ui.config
 */
angular.module('AngularUpstart.directives', [])
  .directive('uiSortable', function() {
    return function(scope, element, attrs){
      element.sortable({
        grid: [ 3, 3 ],
        update: function(event, ui){
          var sort = element.sortable('toArray');
          scope.postSort(sort)
        }
      });
    };
  })
  .directive('toggleEdit', [
    function(){
      return {
        restrict: 'C',
        link: function (scope, element, attr) {
          element.bind('click',function (event) {
            $(event.target).parents('tr').children('td').children('.edit-reading').toggle();
            $(event.target).parents('tr').children('td').children('.show-reading').toggle();
          });
        }
      };
  }])
  .directive('modal', function () {
    return {
      template: '<div class="modal fade">' +
          '<div class="modal-dialog">' +
            '<div class="modal-content" ng-transclude>' +
            '</div>' +
          '</div>' +
        '</div>',
      restrict: 'E',
      transclude: true,
      replace:true,
      scope:true,
      link: function postLink(scope, element, attrs) {
        scope.title = attrs.title;

        scope.$watch(attrs.visible, function(value){
          if(value == true)
            $(element).modal('show');
          else
            $(element).modal('hide');
        });

        $(element).on('shown.bs.modal', function(){
          scope.$apply(function(){
            scope.$parent[attrs.visible] = true;
          });
        });

        $(element).on('hidden.bs.modal', function(){
          scope.$apply(function(){
            scope.$parent[attrs.visible] = false;
            scope.hideModal();
          });
        });
      }
    };
  })
  .directive('ngConfirmClick', [
    function(){
      return {
        link: function (scope, element, attr) {
          var msg = attr.ngConfirmClick || "Are you sure?";
          var clickAction = attr.confirmedClick;
          element.bind('click',function (event) {
            if ( window.confirm(msg) ) {
              scope.$eval(clickAction)
            }
          });
        }
      };
  }])

