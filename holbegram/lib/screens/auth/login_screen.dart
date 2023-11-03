import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:holbegram/screens/auth/signup_screen.dart';
import 'package:holbegram/screens/home.dart';
import 'package:holbegram/widgets/text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _passwordVisible;
  }

  @override
  void dispose() {
    // TODO: implement dispose

    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 28,
              ),
              const Text(
                'Holbegram',
                style: TextStyle(fontFamily: 'Billabong', fontSize: 50),
              ),
              Image.asset(
                'assets/images/img.png',
                width: 80,
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 28,
                    ),
                    TextFieldInput(
                      isPassword: false,
                      controller: emailController,
                      hintText: "email",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFieldInput(
                      controller: passwordController,
                      isPassword: !_passwordVisible,
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        alignment: Alignment.bottomLeft,
                        icon: _passwordVisible
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(218, 226, 37, 24),
                          ),
                        ),
                        onPressed: () async {
                          String email = emailController.text;
                          String password = passwordController.text;
                          String resulat = await AuthMethods()
                              .login(email: email, password: password);
                          if (resulat == "success") {
                            await userProvider.refreshUser();

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                              ((route) => false),
                            );
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //   content: Text(resulat),
                            //   ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(resulat),
                            ));
                          }
                        },
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Forgot your login details ? '),
                        Text(
                          'get helpe logging in ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Flexible(
                      flex: 0,
                      child: Container(),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have  an account"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(218, 226, 37, 24)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: const Divider(
                            thickness: 2,
                          ),
                        ),
                        Text(
                          "OR",
                          style: TextStyle(fontSize: 20),
                        ),
                        Flexible(
                          child: const Divider(
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',
                          width: 40,
                          height: 40,
                        ),
                        const Text("Sign in with Google"),
                      ],
                    )
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
