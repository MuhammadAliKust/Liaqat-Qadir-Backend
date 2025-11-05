import 'package:flutter/material.dart';
import 'package:liaqat_qadir_backend/providers/user.dart';
import 'package:liaqat_qadir_backend/service/auth.dart';
import 'package:liaqat_qadir_backend/service/user.dart';
import 'package:liaqat_qadir_backend/views/profile.dart';
import 'package:liaqat_qadir_backend/views/sign_up.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Column(
        children: [
          TextField(controller: emailController),
          TextField(controller: pwdController),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (emailController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Email cannot be empty.")),
                );
                return;
              }
              if (pwdController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Password cannot be empty.")),
                );
                return;
              }
              try {
                await AuthServices()
                    .login(
                      email: emailController.text,
                      password: pwdController.text,
                    )
                    .then((val) async {
                      await UserServices().getUser(val.uid).then((userData) {
                        userProvider.setUser(userData);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Message"),
                              content: Text(
                                "${userData.name.toString()} has been logged in successfully",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProfileView(),
                                      ),
                                    );
                                  },
                                  child: Text("Oka"),
                                ),
                              ],
                            );
                          },
                        );
                      });
                    });
              } catch (e) {
                isLoading = false;
                setState(() {});
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
            child: Text("Login"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpView()),
              );
            },
            child: Text("Go to SignUp"),
          ),
        ],
      ),
    );
  }
}
