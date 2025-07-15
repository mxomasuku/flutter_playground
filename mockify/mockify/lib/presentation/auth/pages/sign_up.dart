import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mockify/common/widgets/appbar/appbar.dart';
import 'package:mockify/common/widgets/basic_app_button.dart';
import 'package:mockify/core/configs/assets/app_vectors.dart';
import 'package:mockify/data/models/auth/create_user_req.dart';
import 'package:mockify/domain/usecases/auth/signup.dart';
import 'package:mockify/presentation/auth/pages/sign_in.dart';
import 'package:mockify/presentation/root/pages/root.dart';
import 'package:mockify/service_locator.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _fullName.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

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
            _registerText(),
            const SizedBox(height: 50),
            _fullNameField(),
            const SizedBox(height: 20),
            _emailField(),
            const SizedBox(height: 20),
            _passwordField(),
            const SizedBox(height: 20),
            BasicAppButton(
              title: 'Create Account',
              onPressed: () async {
                final result = await serviceLocator<SignUpUseCase>().call(
                  params: CreateUserReq(
                    email: _email.text.trim(),
                    fullName: _fullName.text.trim(),
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

  Widget _registerText() => const Text(
    'Register',
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
  );

  Widget _fullNameField() => TextField(
    controller: _fullName,
    decoration: const InputDecoration(hintText: 'Full Name'),
  );

  Widget _emailField() => TextField(
    controller: _email,
    decoration: const InputDecoration(hintText: 'Email'),
  );

  Widget _passwordField() => TextField(
    controller: _password,
    decoration: const InputDecoration(hintText: 'Password'),
  );

  Widget _signinText(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Do you have an account? ',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SignIn()),
            );
          },
          child: const Text('Sign In'),
        ),
      ],
    ),
  );
}
