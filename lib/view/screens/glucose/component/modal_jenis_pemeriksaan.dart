import 'package:flutter/material.dart';
import 'package:gluecose_monitor/utill/styles.dart';
import 'package:sizer/sizer.dart';

class ModalJenisPemeriksaan extends StatelessWidget {
  const ModalJenisPemeriksaan();

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> jenisPemeriksaan = [
      {"id": 1, "pemeriksaan": "After Waking Up"},
      {"id": 2, "pemeriksaan": "1-2 Hours After Breakfast"},
      {"id": 3, "pemeriksaan": "Before Lunch"},
      {"id": 4, "pemeriksaan": "1-2 Hours After Lunch"},
      {"id": 5, "pemeriksaan": "Before Dinner"},
      {"id": 6, "pemeriksaan": "1-2 Hours After Dinner"},
      {"id": 7, "pemeriksaan": "Before Night Sleep"},
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.5.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.separated(
            itemCount: jenisPemeriksaan.length,
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: 1.h);
            },
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.pop(context, {
                    'id': jenisPemeriksaan[index]['id'],
                    'pemeriksaan': jenisPemeriksaan[index]['pemeriksaan'],
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: Text(
                    jenisPemeriksaan[index]['pemeriksaan'],
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
