import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/const_colors.dart';
import '../services/auth.dart';
import '../widgets/widgets.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String route_name = "sign_up";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = new TextEditingController();

  final TextEditingController _passwordController = new TextEditingController();

  final TextEditingController _nameController = new TextEditingController();

  final GlobalKey<FormState> _formKey = new GlobalKey();

  void signUp() {
    //here we suppos to create the user account
    bool valid = _formKey.currentState!.validate();
    if (valid) {
      context.read<Auth>().authenticate(
            _emailController.text,
            _passwordController.text,
            false,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KMainColor,
      body: LayoutBuilder(
        builder: (ctx, constraints) {
          final double width =
              constraints.maxWidth > 300 ? 300 : constraints.maxWidth;
          return Form(
            key: _formKey,
            child: ListView(
              children: [
                LogoBuilder(constraints: constraints),
                SizedBox(height: constraints.maxHeight * 0.1),
                CustomTextField(
                  hint: "Enter your name",
                  icon: Icons.perm_identity,
                  obscureText: false,
                  controller: _nameController,
                  validator: (String? name) {
                    if (name == null || name.isEmpty) {
                      return "Please enter your name";
                    }
                  },
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                CustomTextField(
                  hint: "Enter your email",
                  icon: Icons.email,
                  obscureText: false,
                  controller: _emailController,
                  validator: (String? email) {
                    if (email == null ||
                        !(email.contains(RegExp(
                            "[a-zA-Z0-9]+[@][a-zA-Z0-9]+[.][a-zA-Z0-9]+")))) {
                      return "Please enter a valid email";
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                CustomTextField(
                  hint: "Enter your password",
                  icon: Icons.lock,
                  obscureText: true,
                  controller: _passwordController,
                  validator: (String? password) {
                    if (password == null) {
                      return "Please enter a password";
                    }
                    if (password.length < 8) {
                      return "The password must have at least eight characters";
                    }
                    if (!password.contains(RegExp("[a-z]"))) {
                      return "The password must contains at least one lower character";
                    }
                    if (!password.contains(RegExp("[A-Z]"))) {
                      return "The password must contains at least one upper character";
                    }
                    if (!password.contains(RegExp("[0-9]"))) {
                      return "The password must contains at least one number";
                    }
                    if (!password.contains(RegExp("[^a-zA-Z0-9]"))) {
                      return "The password must contains at least one special character";
                    }
                  },
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                GestureDetector(
                  onTap: signUp,
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: width * 2 / 7),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //need to move to the sign up screen
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.route_name);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
