import 'package:flutter/material.dart';
import 'package:gluecose_monitor/utill/styles.dart';
import 'package:sizer/sizer.dart';

class ModalMultipleChoose extends StatelessWidget {
  const ModalMultipleChoose();

  @override
  Widget build(BuildContext context) {
    List jenisolahraga = ['Yes', 'No'];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.5.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.separated(
            itemCount: jenisolahraga.length,
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: 1.h);
            },
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.pop(context, jenisolahraga[index]);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: Text(
                    jenisolahraga[index],
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
