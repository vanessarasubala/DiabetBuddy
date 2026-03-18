// ignore_for_file: unnecessary_statements

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gluecose_monitor/data/model/gluecose_model.dart';
import 'package:gluecose_monitor/provider/gluecose_monitoring_provider.dart';
import 'package:gluecose_monitor/utill/color_resources.dart';
import 'package:gluecose_monitor/utill/routes.dart';
import 'package:gluecose_monitor/utill/strings.dart';
import 'package:gluecose_monitor/utill/styles.dart';
import 'package:gluecose_monitor/view/base/primary_button.dart';
import 'package:gluecose_monitor/view/base/primary_icon_button.dart';
import 'package:gluecose_monitor/view/screens/glucose/analize_screen.dart';
import 'package:gluecose_monitor/view/screens/glucose/history_screen.dart';
import 'package:gluecose_monitor/view/screens/home/component/group_data.dart';
import 'package:gluecose_monitor/view/screens/home/component/titles.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime date = DateTime.now();
  int index = 0;

  @override
  void initState() {
    super.initState();
  }

  void loadData({@required String date, String index}) {
    print('tanggal $date');

    Provider.of<GluecoseMonitoringProvider>(context, listen: false)
        .getGluecoseMonitoring(
            date: date, index: (index != null) ? index : null);
  }

  @override
  Widget build(BuildContext context) {
    loadData(date: getShortDate(date));
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Theme.of(context).primaryColor,
          size: 50,
        ),
      ),
      child: Consumer<GluecoseMonitoringProvider>(
        builder: (context, gluecoseMonitoringProvider, child) {
          final _axis = gluecoseMonitoringProvider.axis;
          final _data = gluecoseMonitoringProvider.data;
          List<int> _value = [];
          List<BarChartGroupData> _items = [];
          List<GluecoseMonitorModel> _diagnosis =
              gluecoseMonitoringProvider.diagnosis;
          GluecoseMonitorModel _gluecoseMonitorModel =
              gluecoseMonitoringProvider.gluecoseMonitorModel;
          String _checkingType = _gluecoseMonitorModel?.checkingType;
          print('checking type >> ${_gluecoseMonitorModel?.checkingType}');

          if (_data.isNotEmpty) {
            for (var value in _data) {
              _value.add(int.parse(value[0].toString()));
            }
            for (var index = 0; index < _data.length; index++) {
              print('max data $index >> ${_value.reduce(max)}');
              _items.add(
                makeGroupData(
                  index,
                  double.parse(_data[index][0].toString()),
                  _value.reduce(max).toDouble(),
                  Color(int.parse(_data[index][1].toString())),
                ),
              );
            }
          }

          if (gluecoseMonitoringProvider.isLoading)
            context.loaderOverlay.show();
          else
            context.loaderOverlay.hide();

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text(
                'Glucose Monitoring',
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
                      Navigator.pushNamed(context, Routes.PROFILE_SCREEN);
                    },
                    child: Image.asset(
                      'assets/icon/detail_profile.png',
                      width: 25,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
            body: (_gluecoseMonitorModel != null)
                ? Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(4.h, 1.h, 4.h, 3.h),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Glucose Graphic',
                                textAlign: TextAlign.center,
                                style: poppinsBold.copyWith(
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(width: 2.h),
                              Row(
                                children: [
                                  InkWell(
                                    child: Text(
                                      getFormattedDate(date),
                                      textAlign: TextAlign.center,
                                      style: poppinsRegular.copyWith(
                                        fontSize: 9.sp,
                                        color: Color(0xFFADA4A5),
                                      ),
                                    ),
                                    onTap: () async {
                                      final DateTime picker =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000, 8),
                                        lastDate:
                                            DateTime(DateTime.now().year + 10),
                                        locale: Locale('en'),
                                      );
                                      setState(() {
                                        date = picker;
                                      });
                                      loadData(date: getShortDate(picker));
                                    },
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Color(0xFFADA4A5),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 3.h),
                          Container(
                            padding: EdgeInsets.fromLTRB(4.h, 4.h, 4.h, 2.h),
                            height: 40.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text(
                                      'mg/dl',
                                      style: poppinsBold.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                Expanded(
                                  child: BarChart(
                                    BarChartData(
                                      maxY: _value.reduce(max).toDouble(),
                                      titlesData: FlTitlesData(
                                        show: true,
                                        rightTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                        topTitles: AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false)),
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget: (value, meta) {
                                              return SideTitleWidget(
                                                axisSide: meta.axisSide,
                                                space: 2.h, //margin top
                                                child: Text(
                                                  _axis[value.toInt()],
                                                  style: poppinsMedium.copyWith(
                                                    color: Color(0xFF7B6F72),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 9.sp,
                                                  ),
                                                ),
                                              );
                                            },
                                            reservedSize: 42,
                                          ),
                                        ),
                                        leftTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            reservedSize: 28,
                                            interval: 1,
                                            getTitlesWidget: leftTitles,
                                          ),
                                        ),
                                      ),
                                      borderData: FlBorderData(
                                        show: false,
                                      ),
                                      barGroups: _items,
                                      gridData: FlGridData(show: false),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            'Input Hasil Pemeriksaan Gula darah',
                            style: poppinsRegular.copyWith(
                              fontSize: 10.sp,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          PrimaryIconButton(
                            icon: Icons.add,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.INPUT_GLUCOSE_SCREEN);
                            },
                          ),
                          SizedBox(height: 3.h),
                          Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  child: Row(
                                    children: [
                                      Text(
                                        _checkingType,
                                        style: poppinsRegular.copyWith(
                                          fontSize: 11.sp,
                                          color: Color(0xFFADA4A5),
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: Color(0xFFADA4A5),
                                      ),
                                    ],
                                  ),
                                  onTap: () async {
                                    final data = await showModalBottomSheet(
                                      context: context,
                                      builder: (context) => Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3.h, horizontal: 2.5.h),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListView.separated(
                                              itemCount: _diagnosis.length,
                                              shrinkWrap: true,
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Divider(height: 1.h);
                                              },
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return InkWell(
                                                  onTap: () {
                                                    _checkingType =
                                                        _diagnosis[index]
                                                            .checkingType;
                                                    print(
                                                        'checking type ${_gluecoseMonitorModel.checkingType}');

                                                    Navigator.pop(context,
                                                        index.toString());
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 1.5.h),
                                                    child: Text(
                                                      _diagnosis[index]
                                                          .checkingType,
                                                      style: poppinsRegular
                                                          .copyWith(
                                                        fontSize: 12.sp,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );

                                    if (data != null)
                                      loadData(
                                        date: getShortDate(date),
                                        index: data,
                                      );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 1.5.h),
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 3.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF9DCEFF).withOpacity(0.3),
                                  Color(0xFF92A3FD).withOpacity(0.3),
                                ],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/icon/humidity.png',
                                      height: 14.sp,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    SizedBox(width: 1.h),
                                    Text(
                                      '${_gluecoseMonitorModel.gluecoseResult.toString()} mg/dl',
                                      style: poppinsBold.copyWith(
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  _gluecoseMonitorModel.checkingType,
                                  style: poppinsMedium.copyWith(
                                    fontSize: 12.sp,
                                    color: Color(0xFFFFB164),
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                Text(
                                  _gluecoseMonitorModel.suggest,
                                  style: poppinsRegular.copyWith(
                                    fontSize: 10.sp,
                                    color: Color(0xFF7B6F72),
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: PrimaryButton(
                                        label: 'History',
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HistoryScreen(
                                                date: getShortDate(date),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 2.h),
                                    Expanded(
                                      child: PrimaryButton(
                                        label: 'Analyze',
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AnalizeScreen(
                                                      gluecoseId:
                                                          _gluecoseMonitorModel
                                                              .gluecoseId),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(4.h, 1.h, 4.h, 3.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Glucose Graphic',
                              textAlign: TextAlign.center,
                              style: poppinsBold.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(width: 2.h),
                            Row(
                              children: [
                                InkWell(
                                  child: Text(
                                    getFormattedDate(date),
                                    textAlign: TextAlign.center,
                                    style: poppinsRegular.copyWith(
                                      fontSize: 9.sp,
                                      color: Color(0xFFADA4A5),
                                    ),
                                  ),
                                  onTap: () async {
                                    final DateTime picker =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000, 8),
                                      lastDate:
                                          DateTime(DateTime.now().year + 10),
                                      locale: Locale('en'),
                                    );
                                    setState(() {
                                      date = picker;
                                    });
                                    loadData(date: getShortDate(picker));
                                  },
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Color(0xFFADA4A5),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          'Input Hasil Pemeriksaan Gula darah',
                          style: poppinsRegular.copyWith(
                            fontSize: 10.sp,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        PrimaryIconButton(
                          icon: Icons.add,
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.INPUT_GLUCOSE_SCREEN);
                          },
                        ),
                        SizedBox(height: 3.h),
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.search_off_rounded,
                                  size: 120,
                                  color: Color(0xFF9DCEFF),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'There is nothing data to shown',
                                  textAlign: TextAlign.center,
                                  style: poppinsRegular.copyWith(
                                    fontSize: 10.sp,
                                    color: Color(0xFFADA4A5),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
