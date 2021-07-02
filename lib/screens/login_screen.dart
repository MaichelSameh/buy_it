import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/const_colors.dart';
import '../services/auth.dart';
import '../widgets/widgets.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static const route_name = "login_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  void login() {
    //here we suppos to log the user in
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
                  hint: "Enter your email",
                  icon: Icons.email,
                  obscureText: false,
                  controller: _emailController,
                  validator: (String? email) {},
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                CustomTextField(
                  hint: "Enter your password",
                  icon: Icons.lock,
                  obscureText: true,
                  controller: _passwordController,
                  validator: (String? password) {},
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                GestureDetector(
                  onTap: login,
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: width * 2 / 7),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //need to move to the sign up screen
                        Navigator.of(context)
                            .pushReplacementNamed(SignUpScreen.route_name);
                      },
                      child: Text(
                        "Sign up",
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
