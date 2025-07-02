import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Payment/viewmodel/PaymentViewModel.dart';
import 'package:kamal_greet_web_2/Payment/widgets/PaymentAppSelector.dart';
import 'package:kamal_greet_web_2/Payment/widgets/PaymentMethodRadioTile.dart';
import 'package:kamal_greet_web_2/Utils/widgets/PaddingGenerator.dart';
import '../../Utils/values/AppColors.dart';
import '../../Utils/widgets/DynamicButton.dart';

final PaymentViewModel paymentCtrl = Get.put(PaymentViewModel());

class PaymentScreen extends StatefulWidget {
  final String? id;

  const PaymentScreen({super.key, this.id});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    paymentCtrl.getPayment();
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
              "Payment Gateway Setting",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          backgroundColor: AppColors.creationScreenBackground,
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.16),
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
              paymentAppSelector(),
              formPadding(),

              // /// Course TITLE
              // creationSubTitle(
              //     "Offer name",
              //     DynamicTextfield(
              //       controller: paymentCtrl.offerNameController,
              //       fillColor: AppColors.whiteCard,
              //       hintText: "Enter offer ",
              //     )),
              // formPadding(),
              //
              // /// display content
              // creationSubTitle(
              //     "Display content",
              //     DynamicTextfield(
              //       controller: paymentCtrl.displayTextController,
              //       fillColor: AppColors.whiteCard,
              //       hintText: "Enter display name, use '@' for line change",
              //     )),
              // formPadding(),

              const PaymentMethodRadioTile(),
              // formPadding(),
              // Row(
              //   children: [
              //     Flexible(
              //       child: Obx(
              //         () => CheckboxListTile(
              //           controlAffinity: ListTileControlAffinity.leading,
              //           title: const Text("is_checkboxshow"),
              //           value: paymentCtrl.isCheckboxShow.value,
              //           onChanged: (bool? value) {
              //             paymentCtrl.isCheckboxShow.value = value!;
              //             paymentCtrl.isCheckboxShow.refresh();
              //           },
              //         ),
              //       ),
              //     ),
              //     Flexible(
              //       child: Obx(
              //         () => CheckboxListTile(
              //           controlAffinity: ListTileControlAffinity.leading,
              //           title: const Text("is_singlepayment"),
              //           value: paymentCtrl.isSinglePayment.value,
              //           onChanged: (bool? value) {
              //             paymentCtrl.isSinglePayment.value = value!;
              //             paymentCtrl.isSinglePayment.refresh();
              //           },
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              //
              // formPadding(),
              //
              // /// Course mrp and payable amount
              //
              // Row(
              //   children: [
              //     Flexible(
              //       flex: 1,
              //       child: creationSubTitle(
              //           "MRP",
              //           DynamicTextfield(
              //               onChange: (value) {
              //                 if (paymentCtrl.mrpController.text.isEmpty) {
              //                   paymentCtrl.enablePayable.value = false;
              //                   paymentCtrl.enablePayable.refresh();
              //                   paymentCtrl.payableController.clear();
              //                 } else {
              //                   paymentCtrl.enablePayable.value = true;
              //                   paymentCtrl.enablePayable.refresh();
              //                 }
              //               },
              //               inputFormatters: [
              //                 LengthLimitingTextInputFormatter(5),
              //                 FilteringTextInputFormatter.allow(RegExp(r'\d'))
              //               ],
              //               controller: paymentCtrl.mrpController,
              //               fillColor: AppColors.whiteCard,
              //               hintText: "Enter Course MRP")),
              //     ),
              //     const SizedBox(
              //       width: 20,
              //     ),
              //     Flexible(
              //       flex: 1,
              //       child: creationSubTitle(
              //           "Payable Amount",
              //           Obx(
              //             () => DynamicTextfield(
              //                 readOnly: !paymentCtrl.enablePayable.value,
              //                 onTap: () {
              //                   if (paymentCtrl.enablePayable.value == false) {
              //                     EasyLoading.showError("Enter MRP");
              //                   }
              //                 },
              //                 onChange: (value) {
              //                   if (paymentCtrl
              //                       .payableController.text.isEmpty) {
              //                     paymentCtrl.offerDiscountController.clear();
              //                   }
              //                   if (int.parse(
              //                           paymentCtrl.payableController.text) >
              //                       int.parse(paymentCtrl.mrpController.text)) {
              //                     EasyLoading.showError(
              //                         "Payable amount cannot be greater than mrp");
              //                     paymentCtrl.offerDiscountController.clear();
              //                   } else {
              //                     paymentCtrl.calculateOfferPercentage();
              //                   }
              //                 },
              //                 inputFormatters: [
              //                   LengthLimitingTextInputFormatter(5),
              //                   FilteringTextInputFormatter.allow(RegExp(r'\d'))
              //                 ],
              //                 controller: paymentCtrl.payableController,
              //                 fillColor: AppColors.whiteCard,
              //                 hintText: "Enter Course Payable amount"),
              //           )),
              //     ),
              //   ],
              // ),
              // formPadding(),
              //
              // Row(
              //   children: [
              //     Flexible(
              //       flex: 1,
              //       child: creationSubTitle(
              //           "Offer Percentage",
              //           DynamicTextfield(
              //             enabled: false,
              //             controller: paymentCtrl.offerDiscountController,
              //             fillColor: AppColors.whiteCard,
              //           )),
              //     ),
              //     const Flexible(
              //       child: SizedBox(
              //         width: 20,
              //       ),
              //     ),
              //   ],
              // ),
              // formPadding(),

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
                      context.pop(true);
                    },
                  ),

                  /// SUBMIT BUTTON
                  DynamicButton(
                    onTap: () {
                      paymentCtrl.updatePayment();
                    },
                    text: "Update",
                    height: MediaQuery.of(context).size.width * 0.05,
                    width: MediaQuery.of(context).size.width * 0.3,
                    textSize: 16,
                    radius: 50,
                    textColor: Colors.black,
                    boldness: FontWeight.w500,
                    backgroundColor: AppColors.creationSubmitButton,
                  ),
                ],
              ),
              formPaddingPlus(),
            ],
          ),
        ),
      ),
    );
  }
}
