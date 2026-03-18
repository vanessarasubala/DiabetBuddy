import 'package:flutter/material.dart';
import 'package:gluecose_monitor/utill/styles.dart';
import 'package:sizer/sizer.dart';

Widget infographCard({double value, String title}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 4.h),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 0,
          blurRadius: 4,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value.toStringAsFixed(0),
          style: poppinsRegular.copyWith(
            fontSize: 16,
            color: Color(0xFF9DCEFF),
          ),
        ),
        Text(
          title,
          style: poppinsRegular.copyWith(
            fontSize: 12,
            color: Color(0xFF7B6F72),
          ),
        ),
      ],
    ),
  );
}
