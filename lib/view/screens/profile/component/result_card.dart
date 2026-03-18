import 'package:flutter/material.dart';
import 'package:gluecose_monitor/utill/color_resources.dart';
import 'package:gluecose_monitor/utill/styles.dart';
import 'package:sizer/sizer.dart';

Widget resultCard({String value}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 4.h),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        colors: [
          Color(0xFF9DCEFF),
          Color(0xFF92A3FD),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF92A3FD).withOpacity(0.3),
          spreadRadius: 0,
          blurRadius: 10,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: poppinsMedium.copyWith(
            fontSize: 20.sp,
            color: ColorResources.COLOR_WHITE,
          ),
        ),
        Text(
          'mg/dl',
          style: poppinsMedium.copyWith(
            fontSize: 13.sp,
            color: ColorResources.COLOR_WHITE,
          ),
        ),
      ],
    ),
  );
}
