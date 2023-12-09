import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String userEmail;
  final User user;
  final String displayName;

  ProfilePage({
    required this.user,
    required this.userEmail,
    required this.displayName,
  });

  @override
  Widget build(BuildContext context) {
    String authenticationMethod = determineAuthenticationMethod(user);

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
                onTap: () {
                  print("avatar");
                },
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
                displayName,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20),
             
              if (authenticationMethod == 'Email Signup')
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        print('1');
                      },
                      icon: Icon(Icons.mail, color: Colors.black),
                      label: Text(
                        userEmail,
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        
                      },
                      icon: Icon(Icons.g_translate, color: Colors.black),
                      label: Text(
                        'Link with Google',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                      },
                      icon: Icon(Icons.facebook, color: Colors.black),
                      label: Text(
                        'Link with Facebook',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                    ),
                  ],
                ),
             
              if (authenticationMethod == 'Google')
                Column(
                  children: [
                    SizedBox(height: 16.0),
                    ElevatedButton.icon(
                      onPressed: () {
                      
                      },
                      icon: Icon(Icons.mail, color: Colors.black),
                      label: Text(
                        'Link with Email',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        
                      },
                      icon: Icon(Icons.g_translate, color: Colors.black),
                      label: Text(
                        'Google: $userEmail',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        
                      },
                      icon: Icon(Icons.facebook, color: Colors.black),
                      label: Text(
                        'Link with Facebook',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                    ),
                  ],
                ),


              if (authenticationMethod == 'Facebook')
                Column(
                  children: [
                    SizedBox(height: 16.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        
                      },
                      icon: Icon(Icons.mail, color: Colors.black),
                      label: Text(
                        'Link with Email',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton.icon(
                      onPressed: () {
              
                      },
                      icon: Icon(Icons.g_translate, color: Colors.black),
                      label: Text(
                        'Link with Google',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton.icon(
                      onPressed: () {
                      },
                      icon: Icon(Icons.facebook, color: Colors.black),
                      label: Text(
                        'Facebook: $userEmail',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                    ),
                  ],
                ),
              SizedBox(height: 16.0),
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

  String determineAuthenticationMethod(User user) {
    if (user.providerData.isEmpty) {
      return 'Email Signup';
    }

    if (user.providerData.any((info) => info.providerId == 'google.com')) {
      return 'Google';
    }

    if (user.providerData.any((info) => info.providerId == 'facebook.com')) {
      return 'Facebook';
    }
    return 'Email Signup';
  }
}
