import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gluecose_monitor/provider/auth_provider.dart';
import 'package:gluecose_monitor/utill/color_resources.dart';
import 'package:gluecose_monitor/utill/routes.dart';
import 'package:gluecose_monitor/utill/styles.dart';
import 'package:gluecose_monitor/view/base/custom_field.dart';
import 'package:gluecose_monitor/view/base/custom_snackbar.dart';
import 'package:gluecose_monitor/view/base/primary_button.dart';
import 'package:gluecose_monitor/view/screens/profile/create_profile_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen();

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isCheck = false;

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Theme.of(context).primaryColor,
          size: 50,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          padding: EdgeInsets.fromLTRB(4.h, 7.h, 4.h, 6.h),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Hey there,',
                    style: poppinsRegular.copyWith(
                      fontSize: 12.sp,
                      color: ColorResources.COLOR_BLACK,
                    ),
                  ),
                  Text(
                    'Create an Account',
                    style: poppinsBold.copyWith(fontSize: 18.sp),
                  ),
                  SizedBox(height: 7.h),
                  CustomField(
                    hintText: 'Fullname',
                    controller: _fullnameController,
                    isShowPrefixIcon: true,
                    prefixIconUrl: 'assets/icon/profile.png',
                  ),
                  SizedBox(height: 3.h),
                  CustomField(
                    hintText: 'Phone Number',
                    controller: _phoneController,
                    inputType: TextInputType.number,
                    isShowPrefixIcon: true,
                    prefixIconUrl: 'assets/icon/phone.png',
                  ),
                  SizedBox(height: 3.h),
                  CustomField(
                    hintText: 'Email',
                    controller: _emailController,
                    isShowPrefixIcon: true,
                    inputType: TextInputType.emailAddress,
                    prefixIconUrl: 'assets/icon/message.png',
                  ),
                  SizedBox(height: 3.h),
                  CustomField(
                    hintText: 'Password',
                    isPassword: true,
                    isShowSuffixIcon: true,
                    controller: _passwordController,
                    isShowPrefixIcon: true,
                    prefixIconUrl: 'assets/icon/lock.png',
                    inputAction: TextInputAction.done,
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Checkbox(
                        value: _isCheck,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (val) {
                          setState(() {
                            _isCheck = val;
                          });
                          print('is check >> $_isCheck');
                        },
                      ),
                      // SizedBox(width: 1.h),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: 'By countinuing you accept our ',
                            style: poppinsRegular.copyWith(
                              fontSize: 10.sp,
                              color: Color(0xFFADA4A5),
                            ),
                            children: [
                              TextSpan(
                                text: 'Privacy Policy ',
                                style: poppinsRegular.copyWith(
                                  fontSize: 10.sp,
                                  color: Color(0xFFADA4A5),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text: 'and ',
                                style: poppinsRegular.copyWith(
                                  fontSize: 10.sp,
                                  color: Color(0xFFADA4A5),
                                ),
                              ),
                              TextSpan(
                                text: 'Term of Use',
                                style: poppinsRegular.copyWith(
                                  fontSize: 10.sp,
                                  color: Color(0xFFADA4A5),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7.h),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          label: 'Register',
                          onTap: () async {
                            final Map<String, dynamic> data = {
                              "fullname": _fullnameController.text,
                              "phone_number": _phoneController.text,
                              "email": _emailController.text,
                              "password": _passwordController.text
                            };
                            context.loaderOverlay.show();
                            if (_formKey.currentState.validate() && _isCheck) {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .registration(data)
                                  .then((value) {
                                if (value.isSuccess) {
                                  context.loaderOverlay.hide();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CreateProfileScreen(
                                        email: _emailController.text,
                                      ),
                                    ),
                                    (route) => false,
                                  );
                                } else {
                                  context.loaderOverlay.hide();
                                  showCustomSnackBar(value.message, context);
                                }
                              });
                            } else if (_formKey.currentState.validate() &&
                                !_isCheck) {
                              context.loaderOverlay.hide();
                              showCustomSnackBar(
                                  "You must agree privacy policy and term of use",
                                  context);
                            } else {
                              context.loaderOverlay.hide();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: poppinsMedium.copyWith(
                        fontSize: 10.sp,
                        color: ColorResources.COLOR_BLACK,
                      ),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: poppinsRegular.copyWith(
                            fontSize: 10.sp,
                            color: Color(0xFFEEA4CE),
                          ),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () => Navigator.pushReplacementNamed(
                                context, Routes.LOGIN_SCREEN),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
