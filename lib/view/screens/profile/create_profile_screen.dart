import 'package:flutter/material.dart';
import 'package:gluecose_monitor/provider/profile_provider.dart';
import 'package:gluecose_monitor/utill/color_resources.dart';
import 'package:gluecose_monitor/utill/routes.dart';
import 'package:gluecose_monitor/utill/strings.dart';
import 'package:gluecose_monitor/utill/styles.dart';
import 'package:gluecose_monitor/view/base/custom_field.dart';
import 'package:gluecose_monitor/view/base/custom_snackbar.dart';
import 'package:gluecose_monitor/view/base/primary_button.dart';
import 'package:gluecose_monitor/view/screens/profile/component/modal_diabetes_type.dart';
import 'package:gluecose_monitor/view/screens/profile/component/modal_gender.dart';
import 'package:gluecose_monitor/view/screens/profile/component/modal_multipe_choose.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CreateProfileScreen extends StatelessWidget {
  final String email;
  CreateProfileScreen({this.email});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _genderController = TextEditingController();
    final TextEditingController _dateOfBirthController =
        TextEditingController();
    final TextEditingController _wieghtController = TextEditingController();
    final TextEditingController _heightController = TextEditingController();
    final TextEditingController _diabetesTypeController =
        TextEditingController();
    final TextEditingController _isStressController = TextEditingController();
    final TextEditingController _isSmokeController = TextEditingController();
    int _diabetesTypeId;
    String date;

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
                    "Let's complete your account",
                    textAlign: TextAlign.center,
                    style: poppinsBold.copyWith(fontSize: 18.sp),
                  ),
                  Text(
                    'It will help us to know more about you!',
                    textAlign: TextAlign.center,
                    style: poppinsRegular.copyWith(
                      fontSize: 12.sp,
                      color: ColorResources.COLOR_BLACK,
                    ),
                  ),
                  SizedBox(height: 7.h),
                  CustomField(
                    hintText: 'Choese Gender',
                    isShowSuffixIcon: true,
                    isShowPrefixIcon: true,
                    isIcon: true,
                    readOnly: true,
                    suffixIcon: Icons.keyboard_arrow_down_rounded,
                    controller: _genderController,
                    prefixIconUrl: 'assets/icon/user.png',
                    onTap: () async {
                      final gender = await showModalBottomSheet(
                        context: context,
                        builder: (context) => ModalGender(),
                      );
                      if (gender != null) _genderController.text = gender;
                    },
                  ),
                  SizedBox(height: 3.h),
                  CustomField(
                    hintText: 'Date of Birth',
                    isShowPrefixIcon: true,
                    isIcon: true,
                    readOnly: true,
                    controller: _dateOfBirthController,
                    prefixIconUrl: 'assets/icon/calendar.png',
                    onTap: () async {
                      final DateTime picker = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950, 8),
                        lastDate: DateTime(DateTime.now().year + 10),
                        locale: Locale('en'),
                      );

                      _dateOfBirthController.text = getFormattedDate(picker);
                      date = DateFormat('yyyy-MM-dd', 'en_US').format(picker);
                    },
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomField(
                          hintText: 'Your Weight',
                          controller: _wieghtController,
                          isShowPrefixIcon: true,
                          isIcon: true,
                          inputType: TextInputType.number,
                          prefixIconUrl: 'assets/icon/weight_scale.png',
                        ),
                      ),
                      SizedBox(width: 2.h),
                      Container(
                        padding: EdgeInsets.all(2.5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFFEEA4CE),
                              Color(0xFFC58BF2),
                            ],
                          ),
                        ),
                        child: Text(
                          'KG',
                          style: poppinsRegular.copyWith(
                            fontSize: 8.sp,
                            color: ColorResources.COLOR_WHITE,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomField(
                          hintText: 'Your Height',
                          isShowPrefixIcon: true,
                          isIcon: true,
                          inputType: TextInputType.number,
                          prefixIconUrl: 'assets/icon/swap.png',
                          controller: _heightController,
                        ),
                      ),
                      SizedBox(width: 2.h),
                      Container(
                        padding: EdgeInsets.all(2.5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xFFEEA4CE),
                              Color(0xFFC58BF2),
                            ],
                          ),
                        ),
                        child: Text(
                          'CM',
                          style: poppinsRegular.copyWith(
                            fontSize: 8.sp,
                            color: ColorResources.COLOR_WHITE,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  CustomField(
                    hintText: 'Diabetes Type',
                    isShowSuffixIcon: true,
                    isShowPrefixIcon: true,
                    isIcon: true,
                    readOnly: true,
                    suffixIcon: Icons.keyboard_arrow_down_rounded,
                    controller: _diabetesTypeController,
                    onTap: () async {
                      final _diabetesType = await showModalBottomSheet(
                        context: context,
                        builder: (context) => ModalDiabetesType(),
                      );
                      if (_diabetesType != null) {
                        _diabetesTypeId = _diabetesType['id'];
                        _diabetesTypeController.text =
                            _diabetesType['diabetes_type'];
                      }
                    },
                  ),
                  SizedBox(height: 3.h),
                  CustomField(
                    hintText: 'Do you feel stress lately?',
                    isShowSuffixIcon: true,
                    isShowPrefixIcon: true,
                    isIcon: true,
                    readOnly: true,
                    suffixIcon: Icons.keyboard_arrow_down_rounded,
                    controller: _isStressController,
                    onTap: () async {
                      final _isStress = await showModalBottomSheet(
                        context: context,
                        builder: (context) => ModalMultipleChoose(),
                      );
                      if (_isStress != null)
                        _isStressController.text = _isStress;
                    },
                  ),
                  SizedBox(height: 3.h),
                  CustomField(
                    hintText: 'Do you Smoke?',
                    isShowSuffixIcon: true,
                    isShowPrefixIcon: true,
                    isIcon: true,
                    readOnly: true,
                    suffixIcon: Icons.keyboard_arrow_down_rounded,
                    controller: _isSmokeController,
                    onTap: () async {
                      final _isSmoke = await showModalBottomSheet(
                        context: context,
                        builder: (context) => ModalMultipleChoose(),
                      );
                      if (_isSmoke != null) _isSmokeController.text = _isSmoke;
                    },
                  ),
                  SizedBox(height: 7.h),
                  PrimaryButton(
                    onTap: () {
                      final data = {
                        "gender": _genderController.text,
                        "date_of_birth": date,
                        "weight": _wieghtController.text,
                        "height": _heightController.text,
                        "diabetes_type_id": _diabetesTypeId,
                        "is_stress": _isStressController.text,
                        "is_smoke": _isSmokeController.text
                      };
                      context.loaderOverlay.show();
                      if (_formKey.currentState.validate()) {
                        Provider.of<ProfileProvider>(context, listen: false)
                            .create(data: data)
                            .then((value) {
                          if (value.isSuccess) {
                            if (email != null) {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  Routes.LOGIN_SCREEN, (route) => false);
                            } else {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  Routes.HOME_SCREEN, (route) => false);
                            }
                          } else {
                            showCustomSnackBar(value.message, context);
                            context.loaderOverlay.hide();
                          }
                        });
                      }
                    },
                    label: 'Next',
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
