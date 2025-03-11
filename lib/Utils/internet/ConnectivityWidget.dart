import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'ConnectivityController.dart';

class ConnectivityWidget extends StatefulWidget {
  const ConnectivityWidget({super.key});

  @override
  State<ConnectivityWidget> createState() => _ConnectivityWidgetState();
}

class _ConnectivityWidgetState extends State<ConnectivityWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ConnectivityController>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Image.asset('assets/images/internet.png',
                width: 200, height: 200, fit: BoxFit.fill),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'noNetMessage'.tr,
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 150,
            child: TextButton(
                onPressed: () async {
                  await controller.getConnectivityType();
                  if (controller.connectionType == MConnectivityResult.wifi ||
                      controller.connectionType == MConnectivityResult.mobile) {
                    EasyLoading.showSuccess('netOn'.tr);
                  } else {
                    EasyLoading.showError('netOff'.tr);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.refresh),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      'retry'.tr,
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
