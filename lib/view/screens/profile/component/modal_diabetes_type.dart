import 'package:flutter/material.dart';
import 'package:gluecose_monitor/utill/styles.dart';
import 'package:sizer/sizer.dart';

class ModalDiabetesType extends StatelessWidget {
  const ModalDiabetesType();

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> jenisdiabetesType = [
      {"id": 1, "diabetes_type": "Pradiabetes"},
      {"id": 2, "diabetes_type": "Diabetes Type 1"},
      {"id": 3, "diabetes_type": "Diabetes Type 2"},
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.5.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.separated(
            itemCount: jenisdiabetesType.length,
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: 1.h);
            },
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.pop(context, {
                    'id': jenisdiabetesType[index]['id'],
                    'diabetes_type': jenisdiabetesType[index]['diabetes_type']
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: Text(
                    jenisdiabetesType[index]['diabetes_type'],
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
