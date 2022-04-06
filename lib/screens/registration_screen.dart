import 'package:fire_chat/constants/constants.dart';
import 'package:fire_chat/main.dart';
import 'package:fire_chat/methods/methods.dart';
import 'package:fire_chat/screens/homepage.dart';
import 'package:fire_chat/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
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
                      child: SizedBox(
                        height: 200.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.name,
                    controller: _nameController,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Name',
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Create a new Email',
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    obscureText: true,
                    controller: _passwordController,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Create a new Password',
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  CustomElevatedButton(
                    color: Colors.lightBlueAccent,
                    onPressed: () async {
                      if (_nameController.text.isNotEmpty &&
                          _emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        setState(() {
                          isLoading = true;
                        });
                        createAccount(_nameController.text,
                                _emailController.text, _passwordController.text)
                            .then((user) {
                          if (user != null) {
                            setState(() {
                              isLoading = false;
                            });
                            print('login success');
                            navigatorKey?.currentState
                                ?.pushReplacementNamed(HomePage.id);
                          } else {
                            print('oombi');
                          }
                        });
                      } else {
                        print('enter fields');
                      }
                    },
                    title: 'Register',
                  )
                ],
              ),
      ),
    );
  }
}
