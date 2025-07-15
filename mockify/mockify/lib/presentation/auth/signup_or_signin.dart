import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mockify/common/helpers/is_dark_mode.dart';
import 'package:mockify/common/widgets/appbar/appbar.dart';
import 'package:mockify/common/widgets/basic_app_button.dart';
import 'package:mockify/core/configs/assets/app_images.dart';
import 'package:mockify/core/configs/assets/app_vectors.dart';
import 'package:mockify/core/configs/theme/app_colors.dart';
import 'package:mockify/presentation/auth/pages/sign_in.dart';
import 'package:mockify/presentation/auth/pages/sign_up.dart';

class SignupOrSignin extends StatelessWidget {
  const SignupOrSignin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BasicAppBar(),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppVectors.unionPattern),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(AppImages.authPic),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVectors.bottomPattern),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppVectors.logoSmall),

                  const SizedBox(height: 55),

                  const Text(
                    'Enjoy Listening To Music',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                  SizedBox(height: 21),
                  const Text(
                    'Enjoy Listening To Music Enjoy Listening To Music Enjoy Listening To Music Enjoy Listening To Music Enjoy Listening To Music',
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.grey,
                      fontWeight: FontWeight.w100,
                    ),
                  ),

                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: BasicAppButton(
                          title: 'Register',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                     SignUp(),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextButton(
                          child: Text(
                            'Log In',
                            style: TextStyle(
                              fontSize: 18,
                              color: context.isDarkmode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const SignIn(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
