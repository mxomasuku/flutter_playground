import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mockify/common/widgets/appbar/appbar.dart';
import 'package:mockify/common/widgets/basic_app_button.dart';
import 'package:mockify/core/configs/assets/app_vectors.dart';
import 'package:mockify/presentation/auth/pages/sign_up.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

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
            BasicAppButton(title: 'Sign In', onPressed: () {}),
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
      decoration: InputDecoration(
        hintText: 'Email',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
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
                MaterialPageRoute(
                  builder: (BuildContext context) =>  SignUp(),
                ),
              );
            },
            child: Text('Register Now'),
          ),
        ],
      ),
    );
  }
}
