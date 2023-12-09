import 'dart:convert';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodrecipe/home.dart';
import 'package:http/http.dart' as http;

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool _isPasswordVisible = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _email = "";
  String _password = "";
  void _signinemail() async {
    BuildContext currentContext = context;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      User user = userCredential.user!;
      String defaultImageUrl = 'assets/recipe_log.png';
      String userEmail = user.email!;
      await userCredential.user!.updateProfile(displayName: 'Email Signup');
      await userCredential.user!.reload();
      userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Use the captured context here
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Home(
            user: userCredential.user!,
            userEmail: userCredential.user!.email ?? '',
            userImageURL: defaultImageUrl,
            displayName: "Email",
          ),
        ),
      );
    } catch (error) {
      String errorMessage = 'An error occurred. Please try again.';

      if (error is FirebaseAuthException) {
        if (error.code == 'user-not-found') {
          errorMessage = 'User not found.';
        } else if (error.code == 'wrong-password') {
          errorMessage = 'Password is incorrect.';
        } else if (error.code == 'invalid-credential') {
          errorMessage =
              'Invalid credential. Please check your email and password.';
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
      print(error);
    }
  }

  void _handleGoogleSignIN() async {
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      UserCredential userCredential =
          await _auth.signInWithProvider(_googleAuthProvider);
      String userEmail = userCredential.user?.email ?? '';

      // Get the user's image URL from the Google sign-in provider data
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
            displayName:"Google"// Provide a default image URL if not available
          ),
        ),
      );
    } catch (error) {
      print(error);
    }
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
              // Email input field
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  controller: _emailController,
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
                  }),
              SizedBox(height: 16.0),

              // Password input field
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

              // Sign in button
              ElevatedButton(
                onPressed: ()
                    // Implement your sign-in logic here
                    {
                  _signinemail();
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),

              ElevatedButton.icon(
                onPressed: () {
                  _handleGoogleSignIN();
                },
                icon: Icon(Icons.g_translate, color: Colors.black),
                label: Text(
                  'Sign In with Google',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
              ),
              SizedBox(height: 20.0),

              ElevatedButton.icon(
                onPressed: () {
                  _handleFacebookSignIn();
                },
                icon: Icon(Icons.facebook, color: Colors.black),
                label: Text(
                  'Sign In with Facebook',
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

  Future<void> _handleFacebookSignIn() async {
    try {
      await FacebookAuth.instance.logOut();
      final LoginResult result = await FacebookAuth.instance.login();

      // User canceled the sign-in process
      if (result.status == LoginStatus.cancelled) {
        return;
      }

      final AccessToken accessToken = result.accessToken!;
      final AuthCredential credential =
          FacebookAuthProvider.credential(accessToken.token);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      String userEmail = userCredential.user?.email ?? '';
      await userCredential.user!.updateProfile(displayName: 'facebook');

      // Fetch the Facebook profile image URL
      final graphResponse = await http.get(
        Uri.parse('https://graph.facebook.com/v14.0/me?fields=id,name,email'),
        headers: {'Authorization': 'Bearer ${accessToken.token}'},
      );

      print('Facebook Graph API Response:');
      print(graphResponse.body); // Print the response body

      final Map<String, dynamic> profileData = json.decode(graphResponse.body);

      // Adjust the key based on the actual structure of the response
      final String facebookImageURL = profileData['url'] ?? '';

      print('Facebook login successful:');
      print('User Email: $userEmail');
      print('Facebook Image URL: $facebookImageURL');

      // Navigate to the home page or perform other actions
      // For example, navigate to the Home screen:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(
            user: userCredential.user!,
            userEmail: userEmail,
            userImageURL: facebookImageURL,
            displayName: "FaceBook",
          ),
        ),
      );
    } catch (error) {
      print("Facebook authentication error: $error");
    }
  }
}
