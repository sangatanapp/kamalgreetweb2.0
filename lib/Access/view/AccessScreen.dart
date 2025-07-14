import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kamal_greet_web_2/Access/viewmodel/AccessViewModel.dart';
import 'package:kamal_greet_web_2/Access/widgets/AccessAppSelector.dart';
import 'package:kamal_greet_web_2/Access/widgets/AccessTypeToggle.dart';
import 'package:kamal_greet_web_2/Utils/widgets/PaddingGenerator.dart';
import 'package:kamal_greet_web_2/Utils/widgets/SubtitleGenerator.dart';
import '../../Utils/values/AppColors.dart';
import '../../Utils/widgets/DynamicButton.dart';
import '../../Utils/widgets/DynamicTextfield.dart';

final AccessViewModel accessCtrl = Get.put(AccessViewModel());

class AccessScreen extends StatefulWidget {
  final String? id;

  const AccessScreen({super.key, this.id});

  @override
  State<AccessScreen> createState() => _AccessScreenState();
}

class _AccessScreenState extends State<AccessScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Scaffold(
          appBar: AppBar(
            elevation: 1,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Text(
              "Access Setting",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          backgroundColor: AppColors.creationScreenBackground,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.16),
            child: formWidget(context),
          ));
    });
  }

  Widget formWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.creationScreenBackground,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// app selection
              creationSubTitle("Choose access type", accessTypeToggle()),
              formPadding(),
              creationSubTitle("Choose app type", accessAppSelector()),
              formPadding(),

              creationSubTitle(
                  "Mobile Number".tr,
                  DynamicTextfield(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^[5-9][0-9]{0,9}$')),
                    ],
                    keyboardType: TextInputType.phone,
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return 'validNumber'.tr;
                      } else if (value.length != 10) {
                        return 'validNumber'.tr;
                      } else if (RegExp(r'0000000000').hasMatch(value)) {
                        return 'validNumber'.tr;
                      } else if (value[0] == "1" ||
                          value[0] == "2" ||
                          value[0] == "3" ||
                          value[0] == "4") {
                        return 'validNumber'.tr;
                      }
                      return null;
                    }),
                    controller: accessCtrl.textEditingController,
                    fillColor: AppColors.whiteCard,
                    hintText: "mobile number".tr,
                  )),

              formPadding(),

              Obx(
                () => accessCtrl.whichTypeToggle.value == "givesubscription"
                    ? creationSubTitle(
                        "Subscription End Date".tr,
                        DynamicTextfield(
                          controller: accessCtrl.subscriptionEndDate,
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              accessCtrl.subscriptionEndDate.text =
                                  formattedDate;
                            }
                          },
                          labelText: "end date",
                          suffixIcon: const Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                          ),
                          height: 55,
                        ))
                    : const SizedBox.shrink(),
              ),
              formPadding(),

              /// CANCEL & SUBMIT BUTTON
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// CANCEL BUTTON
                  DynamicButton(
                    text: "Back",
                    height: MediaQuery.of(context).size.width * 0.05,
                    width: MediaQuery.of(context).size.width * 0.3,
                    textSize: 16,
                    radius: 50,
                    textColor: Colors.black,
                    boldness: FontWeight.w500,
                    backgroundColor: Colors.white,
                    onTap: () {
                      Get.back();
                    },
                  ),

                  /// SUBMIT BUTTON
                  Obx(
                    () => DynamicButton(
                      onTap: () {
                        accessCtrl.whichTypeToggle.value == "givesubscription"
                            ? accessCtrl.enableSubscription()
                            : accessCtrl.whichTypeToggle.value ==
                                    "getdisputedata"
                                ? accessCtrl.getDisputeData()
                                : accessCtrl.resetUser();
                        accessCtrl.cleanAccessData();
                      },
                      text: accessCtrl.whichTypeToggle.value == "getdisputedata"
                          ? "Search"
                          : "Update",
                      height: MediaQuery.of(context).size.width * 0.05,
                      width: MediaQuery.of(context).size.width * 0.3,
                      textSize: 16,
                      radius: 50,
                      textColor: Colors.black,
                      boldness: FontWeight.w500,
                      backgroundColor: AppColors.creationSubmitButton,
                    ),
                  ),
                ],
              ),
              formPaddingPlus(),
              Obx(
                () => Visibility(
                  visible: accessCtrl.showDispute.value,
                  child: Center(
                    child: Card(
                      child: DataTable(
                        columnSpacing: 30,
                        border: TableBorder.all(color: Colors.grey.shade300),
                        columns: const [
                          DataColumn(label: Text("name")),
                          DataColumn(label: Text("mobile_number")),
                          DataColumn(label: Text("subscription_type")),
                          DataColumn(label: Text("subscription_id")),
                          DataColumn(label: Text("created_at")),
                        ],
                        rows: accessCtrl.disputeDataList.map((user) {
                          return DataRow(cells: [
                            DataCell(Text(user.name!)),
                            DataCell(Text(user.mobileNumber!)),
                            DataCell(Text(user.subscriptionType!)),
                            DataCell(Text(user.subscriptionId ?? "")),
                            DataCell(Text(user.createdAt!)),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              formPaddingPlus(),
            ],
          ),
        ),
      ),
    );
  }
}
