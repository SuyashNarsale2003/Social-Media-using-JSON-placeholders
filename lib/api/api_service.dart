import 'package:dio/dio.dart';
import '../models/post_model.dart';
import '../models/comment_model.dart';
import '../models/user_model.dart';
import '../app_data.dart';
import '../exceptions/app_exceptions.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<void> fetchPosts() async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/posts');
      AppData().posts = (response.data as List).map((post) => PostModel.fromJson(post)).toList();
    } catch (e) {
      throw AppExceptions('Failed to fetch posts');
    }
  }


  Future<UserModel> fetchUser(int userId) async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/users/$userId');
      UserModel user = UserModel.fromJson(response.data);
      AppData().users.add(user); // Optionally store the user in AppData
      return user;
    } catch (e) {
      throw AppExceptions('Failed to fetch user');
    }
  }

  Future<void> createPost(String title, String body) async {
    try {
      final response = await _dio.post('https://jsonplaceholder.typicode.com/posts', data: {
        'title': title,
        'body': body,
        'userId': 1,
      });
      AppData().posts.add(PostModel.fromJson(response.data));
    } catch (e) {
      throw AppExceptions('Failed to create post');
    }
  }

  Future<Response> postComment(int postId, String name, String email, String body) async {
    try {
      final response = await _dio.post('https://jsonplaceholder.typicode.com/comments', data: {
        'postId': postId,
        'name': name,
        'email': email,
        'body': body,
      });
      return response; // Return the response for further processing
    } catch (e) {
      throw AppExceptions('Failed to post comment');
    }
  }

  Future<void> fetchComments(int postId) async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/comments?postId=$postId');
      AppData().comments = (response.data as List).map((comment) => CommentModel.fromJson(comment)).toList();
    } catch (e) {
      throw AppExceptions('Failed to fetch comments');
    }
  }

}