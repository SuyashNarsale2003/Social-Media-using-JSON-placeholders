import 'models/post_model.dart';
import 'models/comment_model.dart';
import 'models/user_model.dart';

class AppData {
  static final AppData _instance = AppData._internal();
  factory AppData() => _instance;

  List<PostModel> posts = [];
  List<CommentModel> comments = [];
  List<UserModel> users = [];

  AppData._internal();
}