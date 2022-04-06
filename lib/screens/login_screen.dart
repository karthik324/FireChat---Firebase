import 'package:fire_chat/constants/constants.dart';
import 'package:fire_chat/main.dart';
import 'package:fire_chat/methods/methods.dart';
import 'package:fire_chat/screens/homepage.dart';
import 'package:fire_chat/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: isLoading
            ? Center(
                child: Container(
                  height: 60,
                  width: 60,
                  child:
                      const CircularProgressIndicator(color: Colors.blueAccent),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: Hero(
                      tag: 'login',
                      child: Container(
                        height: 200.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    controller: _emailController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      // email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your Email',
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: _passwordController,
                    textAlign: TextAlign.center,
                    obscureText: true,
                    onChanged: (value) {
                      // password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your Password',
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  CustomElevatedButton(
                    color: Colors.lightBlueAccent,
                    onPressed: () async {
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        setState(() {
                          isLoading = true;
                        });
                        logIn(_emailController.text, _passwordController.text)
                            .then((user) {
                          if (user != null) {
                            print('login success');
                            setState(() {
                              isLoading = false;
                            });
                            navigatorKey?.currentState?.pushReplacementNamed(HomePage.id);
                          } else {
                            print('login failed');
                            setState(() {
                              isLoading = false;
                            });
                          }
                        });
                      } else {
                        print('fill forms');
                      }
                    },
                    title: 'Log In',
                  )
                ],
              ),
      ),
    );
  }
}
