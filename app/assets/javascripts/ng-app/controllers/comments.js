angular.module('AngularUpstart')
  .controller('CommentsCtrl', function ($scope, $location, Session, Ability, $http, Alert) {

    $scope.$watch('details_category', function(newValue, oldValue) {
      if(newValue == "comments"){
        $http.get('/api/batches/' + $scope.selected_batch.id + '/comments')
          .success(function(data, status, headers, config) {
            $scope.selected_batch.comments = data;
          })
      }
    });

    $scope.newComment = function(comment, batch) {
      $http.put('/api/batches/' + batch.id + '/add_comment', {
        text: comment.text,
        id: batch.id
      }).
        success(function(data, status, headers, config) {
          batch.comments.push(data)
          $('.chat-input').val("")
          return true
        }).
        error(function(data, status, headers, config) {
          Alert.add("danger", 'sorry, you are not authorized to add a comment', 4000);
        });
    };

  });
