angular.module('AngularUpstart')
  .controller('CommentsCtrl', function ($scope, $location, Session, Ability, $http) {
    $scope.errors = [];

    $scope.newComment = function(comment, batch) {
      $http.put('/api/batches/' + batch.id + '/add_comment', {
        text: comment.text
      }).
        success(function(data, status, headers, config) {
          batch.comments.push(data)
          $('.chat-input').val("")
          return true
        }).
        error(function(data, status, headers, config) {
          $scope.errors.push('sorry, you are not authorized to add a comment');
        });
    };

  });
