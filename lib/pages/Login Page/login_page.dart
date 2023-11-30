import 'package:cafe/Services/FireAuth%20Service/authentication.dart';
import 'package:cafe/pages/main_page.dart';
import 'package:cafe/theme/color_theme.dart';
import 'package:flutter/material.dart';

import '../../widgets/google_signin_button_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  int state = 0; // 0 for login and 1 for signup
  bool process = false;

  final _email_controller = TextEditingController();
  final _password_controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email_controller.dispose();
    _password_controller.dispose();
  }

  _login_or_signup_state(int index) {
    setState(() {
      state = index;
    });
  }

  _get_login_state_color() {
    if (state == 0) {
      return PRIMARY_COLOR;
    } else {
      return Colors.black54;
    }
  }

  _get_signup_state_color() {
    if (state == 1) {
      return PRIMARY_COLOR;
    } else {
      return Colors.black54;
    }
  }

  _get_button_text() {
    if (state == 0) {
      return "Log in";
    } else {
      return "Sign up";
    }
  }

  _check_login() {
    if (Authenticate.isLoggedIn()) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const MainPage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed!'),
          duration: Duration(seconds: 3), // Adjust the duration as needed
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1500,
        width: 400,
        color: const Color.fromARGB(255, 234, 232, 232),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
                  child: Column(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(100, 100, 100, 10),
                        child: Image(
                          image: AssetImage("images/ymca_logo.png"),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: TextButton(
                                onPressed: () {
                                  _login_or_signup_state(0);
                                },
                                child: Text("Login",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: _get_login_state_color(),
                                    )),
                              )),
                          Expanded(
                            flex: 1,
                            child: TextButton(
                              onPressed: () {
                                _login_or_signup_state(1);
                              },
                              child: Text("Sign Up",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: _get_signup_state_color(),
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 30, bottom: 10),
                  child: TextField(
                    controller: _email_controller,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'Enter valid email id as abc@gmail.com',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: PRIMARY_COLOR,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: PRIMARY_COLOR,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: _password_controller,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter secure password',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: PRIMARY_COLOR,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: PRIMARY_COLOR,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: const Center(
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Forgot Password ?',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 90,
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 35.0,
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (state == 0) {
                          if (await Authenticate.login(_email_controller.text,
                              _password_controller.text)) {
                            _check_login();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed!'),
                                duration: Duration(
                                    seconds:
                                        3), // Adjust the duration as needed
                              ),
                            );
                          }
                        } else if (state == 1) {
                          if (await Authenticate.signup(_email_controller.text,
                              _password_controller.text)) {
                            _check_login();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed!'),
                                duration: Duration(
                                    seconds:
                                        3), // Adjust the duration as needed
                              ),
                            );
                          }
                        }
                        print('Successfully log in ');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_COLOR,
                      ),
                      child: Text(
                        _get_button_text(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  padding: const EdgeInsets.all(10),
                  child: const GoogleSignInButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
