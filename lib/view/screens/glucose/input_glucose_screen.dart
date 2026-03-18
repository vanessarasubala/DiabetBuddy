import 'package:flutter/material.dart';
import 'package:gluecose_monitor/provider/gluecose_provider.dart';
import 'package:gluecose_monitor/utill/color_resources.dart';
import 'package:gluecose_monitor/utill/routes.dart';
import 'package:gluecose_monitor/utill/strings.dart';
import 'package:gluecose_monitor/utill/styles.dart';
import 'package:gluecose_monitor/view/base/custom_field.dart';
import 'package:gluecose_monitor/view/base/custom_snackbar.dart';
import 'package:gluecose_monitor/view/base/primary_button.dart';
import 'package:gluecose_monitor/view/screens/glucose/component/modal_jenis_olahraga.dart';
import 'package:gluecose_monitor/view/screens/glucose/component/modal_jenis_pemeriksaan.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class InputGlucoseScreen extends StatelessWidget {
  const InputGlucoseScreen();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _tanggalController = TextEditingController();
    final TextEditingController _jenisPemeriksaanController =
        TextEditingController();
    final TextEditingController _waktuController = TextEditingController();
    final TextEditingController _kadarGulaController = TextEditingController();
    final TextEditingController _durasiTidurController =
        TextEditingController();
    final TextEditingController _jenisOlahragaController =
        TextEditingController();
    final TextEditingController _durasiOlahragaController =
        TextEditingController();
    final TextEditingController _hasilPengecekanController =
        TextEditingController();

    String _checkingDate;
    int _checkingTypeId;
    int _sportTypeId;

    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Theme.of(context).primaryColor,
          size: 50,
        ),
      ),
      child: Scaffold(
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
            'Update Glucose Check',
            textAlign: TextAlign.center,
            style: poppinsBold.copyWith(
              fontSize: 13.sp,
              color: ColorResources.COLOR_BLACK,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(4.h, 1.h, 4.h, 3.h),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomField(
                    hintText: 'Tanggal Pengecekan',
                    controller: _tanggalController,
                    isShowPrefixIcon: true,
                    isIcon: true,
                    readOnly: true,
                    prefixIconUrl: 'assets/icon/calendar.png',
                    onTap: () async {
                      final DateTime picker = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000, 8),
                        lastDate: DateTime(DateTime.now().year + 10),
                        locale: Locale('en'),
                      );
                      _tanggalController.text = getFormattedDate(picker);
                      _checkingDate =
                          DateFormat('yyyy-MM-dd', 'en_US').format(picker);
                    },
                  ),
                  SizedBox(height: 3.h),
                  CustomField(
                    hintText: 'Jenis Pemeriksaan',
                    isShowSuffixIcon: true,
                    isShowPrefixIcon: true,
                    isIcon: true,
                    readOnly: true,
                    suffixIcon: Icons.keyboard_arrow_down_rounded,
                    controller: _jenisPemeriksaanController,
                    onTap: () async {
                      final jenisPemeriksaan = await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return ModalJenisPemeriksaan();
                        },
                      );
                      if (jenisPemeriksaan != null) {
                        _jenisPemeriksaanController.text =
                            jenisPemeriksaan['pemeriksaan'];
                        _checkingTypeId = jenisPemeriksaan['id'];
                      }
                    },
                  ),
                  SizedBox(height: 3.h),
                  CustomField(
                    hintText: 'Waktu Pengecekan',
                    isShowPrefixIcon: true,
                    isIcon: true,
                    readOnly: true,
                    prefixIconUrl: 'assets/icon/calendar.png',
                    controller: _waktuController,
                    onTap: () {
                      final localizations = MaterialLocalizations.of(context);
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        useRootNavigator: false,
                      ).then(
                        (value) {
                          if (value != null) {
                            return _waktuController.text =
                                localizations.formatTimeOfDay(
                              value,
                              alwaysUse24HourFormat: true,
                            );
                          }
                        },
                      );

                      // _waktuController.text = waktuPemeriksaan.formatDateTime;
                    },
                  ),
                  SizedBox(height: 3.h),
                  CustomField(
                    hintText: 'Kadar Gula dalam Makanan Terakhir',
                    isShowPrefixIcon: true,
                    isIcon: true,
                    prefixIconUrl: 'assets/icon/pressure.png',
                    controller: _kadarGulaController,
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: 3.h),
                  CustomField(
                    hintText: 'Durasi Tidur Malam Terakhir',
                    isShowPrefixIcon: true,
                    isIcon: true,
                    prefixIconUrl: 'assets/icon/bed.png',
                    controller: _durasiTidurController,
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: 3.h),
                  CustomField(
                    hintText: 'Jenis Olahraga',
                    isShowSuffixIcon: true,
                    isShowPrefixIcon: true,
                    isIcon: true,
                    readOnly: true,
                    suffixIcon: Icons.keyboard_arrow_down_rounded,
                    controller: _jenisOlahragaController,
                    onTap: () async {
                      final jenisOlahraga = await showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return ModalJenisOlahraga();
                        },
                      );
                      if (jenisOlahraga != null)
                        _jenisOlahragaController.text =
                            jenisOlahraga['olahraga'];
                      _sportTypeId = jenisOlahraga['id'];
                    },
                  ),
                  SizedBox(height: 3.h),
                  CustomField(
                    hintText: 'Durasi Olahraga',
                    isShowPrefixIcon: true,
                    isIcon: true,
                    prefixIconUrl: 'assets/icon/calories.png',
                    controller: _durasiOlahragaController,
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: 3.h),
                  CustomField(
                    hintText: 'Hasil pengecekan (mg/dl)',
                    isShowPrefixIcon: true,
                    isIcon: true,
                    controller: _hasilPengecekanController,
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: 7.h),
                  PrimaryButton(
                    onTap: () {
                      context.loaderOverlay.show();

                      final data = {
                        'checking_date': _checkingDate,
                        'checking_type_id': _checkingTypeId,
                        'checking_time': _waktuController.text,
                        'sugar_level': _kadarGulaController.text,
                        'sleep_duration': _durasiTidurController.text,
                        'sport_type_id': _sportTypeId,
                        'sport_duration': _durasiOlahragaController.text,
                        'gluecose_result': _hasilPengecekanController.text
                      };

                      if (_formKey.currentState.validate()) {
                        Provider.of<GluecoseProvider>(context, listen: false)
                            .createGluecose(data: data)
                            .then(
                          (value) {
                            if (value.isSuccess) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                Routes.HOME_SCREEN,
                                (route) => false,
                              );
                            } else {
                              showCustomSnackBar(value.message, context);
                              context.loaderOverlay.hide();
                            }
                          },
                        );
                      } else {
                        showCustomSnackBar('Terjadi kesalahan', context);
                        context.loaderOverlay.hide();
                      }
                    },
                    label: 'Save',
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
