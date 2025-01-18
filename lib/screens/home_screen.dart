import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmedia/app_data.dart';
import 'package:socialmedia/models/post_model.dart';
import 'package:socialmedia/screens/user_profile_screen.dart';
import '../controllers/post_controller.dart';
import 'post_details_screen.dart';

class HomeScreen extends StatelessWidget {
  final PostController postController = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Social Media Posts',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      
      floatingActionButton: FloatingActionButton(onPressed: (){
        _showCreatePostDialog(context);
      },backgroundColor: Colors.teal,child: Icon(Icons.add,color: Colors.white,),),
      
      
      
      body: Obx(() {
        if (postController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: postController.posts.length,
          itemBuilder: (context, index) {
            final post = postController.posts[index];
            return Card(
              margin: EdgeInsets.all(8),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: IconButton(onPressed: (){
                  Get.to(UserProfileScreen(userId: post.userId));
                }, icon: Icon(Icons.account_circle_outlined)),
                title: Text(
                  post.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  post.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  Get.to(PostDetailsScreen(postId: post.id));
                },
              ),
            );
          },
        );
      }),
    );
  }

  void _showCreatePostDialog(BuildContext context) {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create New Post'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: bodyController,
                  decoration: InputDecoration(labelText: 'Body'),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && bodyController.text.isNotEmpty) {
                  postController.createPost(titleController.text, bodyController.text);
                  Get.back(); // Close the dialog
                  Get.snackbar('Success', 'Post uploaded successfully', snackPosition: SnackPosition.BOTTOM);

                }else{
                  Get.snackbar('Error', 'Please fill all data', snackPosition: SnackPosition.BOTTOM);
                }
              },
              child: Text('Create', style: TextStyle(color: Colors.blueAccent)),
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}