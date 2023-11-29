import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodrecipe/home.dart';

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
    BuildContext currentContext = context; // Capture the context

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );
      User user = userCredential.user!;
      String userEmail = user.email!;

      // Use the captured context here
      Navigator.push(
        currentContext,
        MaterialPageRoute(builder: (context) => Home(userEmail: userEmail)),
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
        BuildContext currentContext = context;
        try {
          GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
          UserCredential userCredential =
              await _auth.signInWithProvider(_googleAuthProvider);
          String userEmail = userCredential.user?.email ?? "";

          Navigator.push(
            currentContext,
            MaterialPageRoute(builder: (context) => Home(userEmail: userEmail)),
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
                  // Implement your Facebook sign-in logic here
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
}

void _handleGoogleSignIN() {
}
