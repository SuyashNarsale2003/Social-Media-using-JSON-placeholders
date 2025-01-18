import 'package:get/get.dart';
import '../api/api_service.dart';
import '../app_data.dart';
import '../exceptions/app_exceptions.dart';
import '../models/post_model.dart';

class PostController extends GetxController {
  final ApiService apiService = ApiService();
  var posts = <PostModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  void fetchPosts() async {
    isLoading(true);
    await apiService.fetchPosts();
    posts.assignAll(AppData().posts);
    isLoading(false);
  }

  void createPost(String title, String body) async {
    try {
      await apiService.createPost(title, body);
      fetchPosts(); // Refresh the posts list
    } catch (e) {
      throw AppExceptions('Failed to upload post');

    }
  }}