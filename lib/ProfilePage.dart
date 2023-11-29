import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String userEmail;
  final User user;

  ProfilePage({required this.user, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
  onTap: () {print("avatar");},
  child: CircleAvatar(
    radius: 50,
    backgroundColor: Colors.white,
    child: Icon(
      Icons.account_circle,
      size: 70,
      color: Colors.black,
    ),
  ),
),

              SizedBox(height: 20),
              Text(
                'User Email:',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 8),
              Text(
                userEmail,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                'User Logged Through :',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 8),
              Text(
                user.displayName ?? 'N/A',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
