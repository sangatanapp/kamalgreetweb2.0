import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kamal_greet_web_2/IosUserData/viewmodel/UserDataViewModel.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityController.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityWidget.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';

final UserDataViewModel userDataCtrl = Get.put(UserDataViewModel());

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreen();
}

class _UserDataScreen extends State<UserDataScreen> {
  @override
  void initState() {
    userDataCtrl.getIosUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Obx(
        () {
          if (connectivityController.connectionType ==
                  MConnectivityResult.wifi ||
              connectivityController.connectionType ==
                  MConnectivityResult.mobile) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: Text("IOS User Data",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black)),
                  centerTitle: true,
                ),
                backgroundColor: AppColors.creationScreenBackground,
                body: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.08),
                  child: Obx(() {
                    switch (userDataCtrl.rxUserDataStatus.value) {
                      case Status.INITIAL:
                        return const SizedBox.shrink();
                      case Status.LOADING:
                        return const Center(child: CircularProgressIndicator());
                      case Status.COMPLETED:
                        return formWidget(context);
                      case Status.ERROR:
                        return const Center(
                            child: Text("Something went wrong"));
                    }
                  }),
                ));
          } else {
            return const ConnectivityWidget();
          }
        },
      );
    });
  }

  Widget formWidget(BuildContext context) {
    return Obx(
      () => Container(
          decoration: BoxDecoration(
            color: AppColors.creationScreenBackground,
          ),
          child: Center(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: DataTable(
                    columnSpacing: 200,
                    headingRowColor:
                        MaterialStateProperty.all(Colors.blueGrey[100]),
                    border: TableBorder.all(color: Colors.grey.shade300),
                    columns: const [
                      DataColumn(
                        label: Text(
                          "Name",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Mobile No.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Payment Status",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Created At",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows: userDataCtrl.iosUserDataList.map((user) {
                      return DataRow(cells: [
                        DataCell(Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              user.name ?? "",
                              style: GoogleFonts.poppins(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ))),
                        DataCell(Text(user.mobileNumber!)),
                        DataCell(
                          Text(
                            user.subscriptionType ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: user.subscriptionType == "success"
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ),
                        DataCell(Text(DateFormat('dd MMM yyyy, hh:mm a')
                            .format(DateTime.parse(user.createdAt!)))),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
