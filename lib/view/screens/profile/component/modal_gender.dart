import 'package:flutter/material.dart';
import 'package:gluecose_monitor/utill/styles.dart';
import 'package:sizer/sizer.dart';

class ModalGender extends StatelessWidget {
  const ModalGender();

  @override
  Widget build(BuildContext context) {
    List gender = ['Male', 'Female'];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.5.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.separated(
            itemCount: gender.length,
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: 1.h);
            },
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.pop(context, gender[index]);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: Text(
                    gender[index],
                    style: poppinsRegular.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
