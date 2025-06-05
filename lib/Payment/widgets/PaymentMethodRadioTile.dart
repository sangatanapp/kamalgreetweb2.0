import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Payment/view/PaymentScreen.dart';

class PaymentMethodRadioTile extends StatefulWidget {
  const PaymentMethodRadioTile({super.key});

  @override
  _PaymentMethodRadioTileState createState() => _PaymentMethodRadioTileState();
}

class _PaymentMethodRadioTileState extends State<PaymentMethodRadioTile> {
  @override
  Widget build(BuildContext context) {
    List<String> paymentMethod = [
      "Recurring payment by razor-pay",
      "Recurring payment by phone-pay"
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Available payment method",
            style:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Card(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: paymentMethod.length,
            itemBuilder: (context, index) {
              return Obx(
                () => RadioListTile<int>(
                  title: Text(paymentMethod[index]),
                  value: index,
                  groupValue: paymentCtrl.groupValue.value,
                  onChanged: (int? value) {
                    paymentCtrl.groupValue.value = value!;
                    paymentCtrl.groupValue.refresh();
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
