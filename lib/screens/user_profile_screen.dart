import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api/api_service.dart';
import '../app_data.dart';
import '../models/user_model.dart';

class UserProfileScreen extends StatelessWidget {
  final int userId;

  UserProfileScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User  Profile',style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.teal,),
      body: FutureBuilder(
        future: ApiService().fetchUser (userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final user = AppData().users.firstWhere((user) => user.id == userId);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Name: ${user.name}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Username: ${user.username}', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 8),
                    Text('Email: ${user.email}', style: TextStyle(fontSize: 18)),


                  ],
                ),
          );
        },
      ),
    );
  }
}