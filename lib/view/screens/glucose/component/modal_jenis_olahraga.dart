import 'package:flutter/material.dart';
import 'package:gluecose_monitor/utill/styles.dart';
import 'package:sizer/sizer.dart';

class ModalJenisOlahraga extends StatelessWidget {
  const ModalJenisOlahraga();

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> jenisolahraga = [
      {"id": 1, "olahraga": "None"},
      {"id": 2, "olahraga": "Light"},
      {"id": 3, "olahraga": "Medium"},
      {"id": 4, "olahraga": "Heavy"},
    ];

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
                  Navigator.pop(context, {
                    'id': jenisolahraga[index]['id'],
                    'olahraga': jenisolahraga[index]['olahraga']
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: Text(
                    jenisolahraga[index]['olahraga'],
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
