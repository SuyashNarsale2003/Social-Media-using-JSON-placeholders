import 'package:get/get.dart';
import '../api/api_service.dart';
import '../app_data.dart';
import '../models/comment_model.dart';
import '../exceptions/app_exceptions.dart';

class CommentController extends GetxController {
  var comments = <CommentModel>[].obs; // Observable list of comments
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchComments(int postId) async {
    isLoading(true);
    try {
      await ApiService().fetchComments(postId);
      comments.assignAll(AppData().comments);
    } catch (e) {
      throw AppExceptions('Failed to fetch comments');
    } finally {
      isLoading(false);
    }
  }

  Future<void> postComment(int postId, String name, String email, String body) async {
    try {
      final response = await ApiService().postComment(postId, name, email, body);
      comments.add(CommentModel.fromJson(response.data)); // Add the new comment to the list
    } catch (e) {
      throw AppExceptions('Failed to post comment');
    }
  }
}