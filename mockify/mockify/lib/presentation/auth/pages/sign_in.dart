import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mockify/common/widgets/appbar/appbar.dart';
import 'package:mockify/common/widgets/basic_app_button.dart';
import 'package:mockify/core/configs/assets/app_vectors.dart';
import 'package:mockify/data/models/auth/sign_in_req.dart';
import 'package:mockify/domain/usecases/auth/signin.dart';
import 'package:mockify/presentation/auth/pages/sign_up.dart';
import 'package:mockify/service_locator.dart';
import 'package:mockify/presentation/root/pages/root.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signinText(context),
      appBar: BasicAppBar(
        title: SvgPicture.asset(AppVectors.logoSmall, height: 40, width: 40),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 8.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            _signinTitle(),
            SizedBox(height: 50),

            _emailField(context),
            SizedBox(height: 20),
            _passwordField(context),
            SizedBox(height: 20),
            BasicAppButton(
              title: 'Sign In',
              onPressed: () async {
                final result = await serviceLocator<SignInUseCase>().call(
                  params: SignInUserReq(
                    email: _email.text.trim(),
                    password: _password.text.trim(),
                  ),
                );

                if (!mounted) return;

                result.fold(
                  (l) {
                    final errorMessage = l.toString();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          errorMessage,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  (r) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => Root()),
                      (route) => false,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _signinTitle() {
    return const Text(
      'Sign In',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: InputDecoration(
        hintText: 'Email',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: InputDecoration(
        hintText: 'Password',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signinText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Not a member ",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),

          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (BuildContext context) => SignUp()),
              );
            },
            child: Text('Register Now'),
          ),
        ],
      ),
    );
  }
}
