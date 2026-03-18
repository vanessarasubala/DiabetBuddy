import 'package:flutter/material.dart';
import 'package:gluecose_monitor/data/model/profile_model.dart';
import 'package:gluecose_monitor/provider/auth_provider.dart';
import 'package:gluecose_monitor/provider/profile_provider.dart';
import 'package:gluecose_monitor/utill/color_resources.dart';
import 'package:gluecose_monitor/utill/routes.dart';
import 'package:gluecose_monitor/utill/styles.dart';
import 'package:gluecose_monitor/view/base/custom_field.dart';
import 'package:gluecose_monitor/view/base/custom_snackbar.dart';
import 'package:gluecose_monitor/view/base/primary_button.dart';
import 'package:gluecose_monitor/view/screens/profile/component/infograph_card.dart';
import 'package:gluecose_monitor/view/screens/profile/component/modal_diabetes_type.dart';
import 'package:gluecose_monitor/view/screens/profile/component/modal_multipe_choose.dart';
import 'package:gluecose_monitor/view/screens/profile/component/result_card.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _wieghtController = TextEditingController();
    final TextEditingController _heightController = TextEditingController();
    final TextEditingController _diabetesTypeController =
        TextEditingController();
    final TextEditingController _isStressController = TextEditingController();
    final TextEditingController _isSmokeController = TextEditingController();
    int _diabetesTypeId;

    Provider.of<ProfileProvider>(context, listen: false).getProfile();

    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Theme.of(context).primaryColor,
          size: 50,
        ),
      ),
      child: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          final ProfileModel _profileModel = profileProvider.profileModel;
          if (_profileModel != null) {
            _wieghtController
              ..text = profileProvider.profileModel.weight.toString();
            _heightController
              ..text = profileProvider.profileModel.height.toString();
            _diabetesTypeController
              ..text = profileProvider.profileModel.diabetesType;
            _isStressController..text = profileProvider.profileModel.isStress;
            _isSmokeController..text = profileProvider.profileModel.isSmoke;
            _diabetesTypeId = profileProvider.profileModel.diabetesTypeId;
          }

          if (_profileModel == null)
            context.loaderOverlay.show();
          else
            context.loaderOverlay.hide();

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: Padding(
                padding: EdgeInsets.only(left: 4.h, top: 2.h, bottom: 2.h),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/icon/back.png',
                    width: 25,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              title: Text(
                'Profile',
                textAlign: TextAlign.center,
                style: poppinsBold.copyWith(
                  fontSize: 13.sp,
                  color: ColorResources.COLOR_BLACK,
                ),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 4.h, top: 2.h, bottom: 2.h),
                  child: InkWell(
                    onTap: () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .logout()
                          .then(
                        (value) {
                          if (value) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, Routes.LOGIN_SCREEN, (route) => false);
                          } else {
                            showCustomSnackBar('Terjadi kesalahan', context);
                          }
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 1.h, horizontal: 1.5.h),
                      decoration: BoxDecoration(
                        color: Color(0xFFF7F8F8),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Image.asset(
                        'assets/icon/logout.png',
                        width: 25,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: (_profileModel != null)
                ? Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(4.h, 1.h, 4.h, 3.h),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/image/user.png',
                                height: 8.h,
                                fit: BoxFit.fitHeight,
                              ),
                              SizedBox(width: 2.h),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _profileModel.fullname,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: poppinsMedium.copyWith(
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Text(
                                      _profileModel.phoneNumber,
                                      style: poppinsRegular.copyWith(
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          resultCard(value: _profileModel.gluecoseResult),
                          SizedBox(height: 3.h),
                          Text(
                            _profileModel.diabetesType,
                            style: poppinsRegular.copyWith(
                              fontSize: 13.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Expanded(
                                child: infographCard(
                                    value: _profileModel.height.toDouble(),
                                    title: 'height'),
                              ),
                              SizedBox(width: 2.h),
                              Expanded(
                                child: infographCard(
                                    value: _profileModel.weight.toDouble(),
                                    title: 'weight'),
                              ),
                              SizedBox(width: 2.h),
                              Expanded(
                                child: infographCard(
                                    value: _profileModel.age.toDouble(),
                                    title: 'age'),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Text(
                                  'Update Data',
                                  style: poppinsRegular.copyWith(
                                    fontSize: 16.sp,
                                    color: Color(0xFF9DCEFF),
                                  ),
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
                                        prefixIconUrl:
                                            'assets/icon/weight_scale.png',
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
                                    final _diabetesType =
                                        await showModalBottomSheet(
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
                                    final _isStress =
                                        await showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return ModalMultipleChoose();
                                      },
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
                                      builder: (context) {
                                        return ModalMultipleChoose();
                                      },
                                    );
                                    if (_isSmoke != null)
                                      _isSmokeController.text = _isSmoke;
                                  },
                                ),
                                SizedBox(height: 7.h),
                                PrimaryButton(
                                  onTap: () {
                                    final data = {
                                      "weight": _wieghtController.text,
                                      "height": _heightController.text,
                                      "diabetes_type_id": _diabetesTypeId,
                                      "is_stress": _isStressController.text,
                                      "is_smoke": _isSmokeController.text
                                    };

                                    context.loaderOverlay.show();
                                    if (_formKey.currentState.validate()) {
                                      Provider.of<ProfileProvider>(context,
                                              listen: false)
                                          .update(data: data)
                                          .then(
                                        (value) {
                                          if (value.isSuccess) {
                                            Navigator.pop(context);
                                            context.loaderOverlay.hide();
                                          } else {
                                            context.loaderOverlay.hide();
                                          }
                                        },
                                      );
                                    }
                                  },
                                  label: 'Save',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          );
        },
      ),
    );
  }
}
