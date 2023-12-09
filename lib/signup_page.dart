import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodrecipe/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  User? _user;
  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.grey,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                obscureText: !_isPasswordVisible,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                obscureText: !_isConfirmPasswordVisible,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_passwordController.text ==
                      _confirmPasswordController.text) {
                    _emailsignup(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Passwords do not match'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton.icon(
                onPressed: _handleGoogleSignUP,
                icon: Icon(Icons.g_translate, color: Colors.black),
                label: Text(
                  'Sign Up with Google',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton.icon(
                onPressed: _handleFacebookSignUp,
                icon: Icon(Icons.facebook, color: Colors.black),
                label: Text(
                  'Sign Up with Facebook',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _emailsignup(BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      await userCredential.user!.updateProfile(displayName: 'Email Signup');
      await userCredential.user!.reload();
      userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      String defaultImageUrl = 'assets/recipe_log.png';

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(
            user: userCredential.user!,
            userEmail: userCredential.user!.email ?? '',
            // userName: ,
            userImageURL: defaultImageUrl,
            displayName: 'Email',
          ),
        ),
      );
    } catch (error) {
      if (error is FirebaseAuthException) {
        String errorMessage = 'Error during registration: ${error.message}';

        if (error.code == 'email-already-in-use') {
          errorMessage = 'The account already exists for that email.';
        } else if (error.code == 'weak-password') {
          errorMessage = 'Password should be at least 6 characters.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        print('Unexpected error during registration: $error');
      }
    }
  }

  Future<void> _handleGoogleSignUP() async {
    try {

      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      UserCredential userCredential =
          await _auth.signInWithProvider(_googleAuthProvider);
      String userEmail = userCredential.user?.email ?? '';

      String? userImageURL =
          userCredential.additionalUserInfo?.profile?['picture'] as String?;

      await userCredential.user!.updateProfile(displayName: 'google');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(
            user: userCredential.user!,
            userEmail: userEmail,
            userImageURL: userImageURL ?? 'default_image_url',
            displayName:'Google', // Provide a default image URL if not available
          ),
        ),
      );
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleFacebookSignUp() async {
    try {
      await FacebookAuth.instance.logOut();
      final LoginResult result = await FacebookAuth.instance.login();

      final AccessToken accessToken = result.accessToken!;
      final AuthCredential credential =
          FacebookAuthProvider.credential(accessToken.token);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      String userEmail = userCredential.user?.email ?? '';
      await userCredential.user!.updateProfile(displayName: 'facebook');
      final graphResponse = await http.get(
        Uri.parse('https://graph.facebook.com/v14.0/me?fields=id,name,email'),
        headers: {'Authorization': 'Bearer ${accessToken.token}'},
      );

      final Map<String, dynamic> userData = json.decode(graphResponse.body);
        String facebookName = userData['name'] ?? '';
        String facebookEmail = userData['email'] ?? '';

      String defaultImageUrl = 'assets/recipe_log.png';
      print('User Email: $facebookEmail');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(
            user: userCredential.user!,
            // username:facebookName,
            userEmail: facebookEmail,
            userImageURL: defaultImageUrl,
            displayName: 'FaceBook',
          ),
        ),
      );
      if (result.status == LoginStatus.cancelled) {
        return;
      }
    } catch (error) {
      print("Facebook authentication error: $error");
    }
  }
}




