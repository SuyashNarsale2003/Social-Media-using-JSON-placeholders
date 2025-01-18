import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmedia/screens/user_profile_screen.dart';
import '../controllers/comment_controller.dart';
import '../models/comment_model.dart';

class PostDetailsScreen extends StatelessWidget {
  final int postId;
  final CommentController commentController = Get.put(CommentController()); // Initialize CommentController
  final TextEditingController commentControllerText = TextEditingController();

  PostDetailsScreen({required this.postId}) {
    // Fetch comments when the screen is initialized
    commentController.fetchComments(postId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details',style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.teal
      ),
      body: Obx(() {
        if (commentController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: commentController.comments.length,
                itemBuilder: (context, index) {
                  final comment = commentController.comments[index];
                  return CommentCard(comment: comment);
                },
              ),
            ),
            CommentInputField(
              controller: commentControllerText,
              onSend: (text) {
                _sendComment(text);
                commentControllerText.clear(); // Clear the input field
              },
            ),
          ],
        );
      }),
    );
  }

  void _sendComment(String commentText) async {
    try {
      String userName = 'You'; // Placeholder for the user's name
      String userEmail = 'you@example.com'; // Placeholder for the user's email

      // Call the CommentController to post the comment
      await commentController.postComment(postId, userName, userEmail, commentText);

      // Show success message
      Get.snackbar('Success', 'Comment posted successfully', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      // Handle error
      Get.snackbar('Error', 'Failed to post comment', snackPosition: SnackPosition.BOTTOM);
    }
  }
}

class CommentCard extends StatelessWidget {
  final CommentModel comment;

  const CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to UserProfileScreen when the comment author's name is tapped
        Get.to(UserProfileScreen(userId: comment.id)); // Assuming comment.id is the userId
      },
      child: Card(
        margin: EdgeInsets.all(8),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Text(comment.name, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(comment.body),
        ),
      ),
    );
  }
}

class CommentInputField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSend;

  const CommentInputField({Key? key, required this.controller, required this.onSend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Add a comment',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.teal)),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                onSend(controller.text);
              }
            },
            child: Text('Send',style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}