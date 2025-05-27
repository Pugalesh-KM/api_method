import 'package:api_method/core/network/network_services.dart';
import '../../features/home/data/models/comment.dart';


class CommentService extends NetworkServices {
  CommentService() : super(baseUrl: 'https://jsonplaceholder.typicode.com/');

  Future<List<Comment>> getAllComments() async {
    List<Comment> allComments = [];
    try {

        final response = await get('comments');
        if (response.statusCode == 200) {
          final commentsJson = response.data as List;
          allComments = commentsJson.map((json) => Comment.fromJson(json)).toList().reversed.toList();
        }else {
          print('Failed to load comments. Status code: ${response.statusCode}');
        }
    } catch (e) {
      print("Error fetching comments: $e");
    }
    return allComments;
  }

  Future<List<Comment>> getSingleComments(int postId) async {
    List<Comment> comments = [];
    try {

      final response = await get('comments', params: {'postId': postId});
      if (response.statusCode == 200) {
        final commentsJson = response.data as List;
        comments = commentsJson.map((json) => Comment.fromJson(json)).toList();
      }else {
        print('Failed to load comments. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching comments: $e");
    }
    return comments;
  }

  Future<Comment?> createComment(String name, String email, String body) async {
    try {
      final response = await post('comments', {
        'name': name,
        'email': email,
        'body': body,
        'postId': 1,
      });

      if (response.statusCode == 201) {
        return Comment.fromJson(response.data);
      }
    } catch (e) {
      print("Error creating comment: $e");
    }
    return null;
  }

  Future<bool> updateComment(int id, String name, String email, String body) async {
    try {
      final response = await put('comments/$id', {
        'name': name,
        'email': email,
        'body': body,
        'postId': 1,
      });

      return response.statusCode == 200;
    } catch (e) {
      print("Error updating comment: $e");
      return false;
    }
  }

  Future<bool> deleteComment(int id) async {
    try {
      final response = await delete('comments/$id');
      return response.statusCode == 200;
    } catch (e) {
      print("Error deleting comment: $e");
      return false;
    }
  }
}
