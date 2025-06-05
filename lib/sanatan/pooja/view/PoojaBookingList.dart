import 'dart:html' as html; // For Flutter Web
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel/excel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityController.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityWidget.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/viewmodel/PoojaBookingListViewModel.dart';
import 'package:kamal_greet_web_2/sanatan/wallpaper/view/AddWallpaperScreen.dart';

final PoojaBookingListViewModel poojaBookingListCtrl =
    Get.put(PoojaBookingListViewModel());

class PoojaBookingList extends StatefulWidget {
  const PoojaBookingList({super.key});

  @override
  State<PoojaBookingList> createState() => _PoojaBookingListState();
}

class _PoojaBookingListState extends State<PoojaBookingList> {
  @override
  void initState() {
    poojaBookingListCtrl.getPoojaBookingList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isMobile = constraints.maxWidth < 800;

        return Obx(
          () => connectivityController.connectionType == MConnectivityResult.wifi ||
              connectivityController.connectionType == MConnectivityResult.mobile
              ? PopScope(
                  child: Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Get.back(),
                      ),
                      centerTitle: true,
                      title: Text(
                        "Pooja Booking Details",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade400,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              final dataList =
                                  poojaBookingListCtrl.poojaBookingListData
                                      .map((item) => {
                                            'name': item.name,
                                            'mobile': item.mobileNumber,
                                            'poojaDate': item.poojaDate,
                                            'id': item.id,
                                            'amount': item.amount,
                                            'paymentStatus': item.paymentStatus,
                                          })
                                      .toList();

                              print("📦 Download Data: $dataList");
                              downloadExcelForWeb(dataList);
                            },
                            icon: const Icon(Icons.download),
                            label: Text("Download Excel",
                                style: GoogleFonts.poppins(fontSize: 16)),
                          ),
                        ),
                      ],
                      backgroundColor: Colors.white,
                      elevation: 2,
                    ),
                    backgroundColor: AppColors.creationScreenBackground,
                    body: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16 : 80, vertical: 30),
                      child: Obx(
                        () => ListView.separated(
                          itemCount:
                              poojaBookingListCtrl.poojaBookingListData.length,
                          itemBuilder: (context, index) {
                            final booking = poojaBookingListCtrl
                                .poojaBookingListData[index];
                            return Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      booking.name ?? "",
                                      style: GoogleFonts.poppins(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    _bookingDetailTile(
                                        icon: Icons.phone,
                                        label: "Mobile Number",
                                        value: booking.mobileNumber ?? ""),
                                    _bookingDetailTile(
                                        icon: Icons.calendar_month,
                                        label: "Pooja Date",
                                        value: booking.poojaDate ?? ""),
                                    _bookingDetailTile(
                                        icon: Icons.numbers,
                                        label: "User ID",
                                        value: booking.id.toString()),
                                    _bookingDetailTile(
                                        icon: Icons.currency_rupee,
                                        label: "Amount",
                                        value: booking.amount.toString()),
                                    _bookingDetailTile(
                                        icon: Icons.payment,
                                        label: "Payment Status",
                                        value: booking.paymentStatus ?? ""),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10),
                        ),
                      ),
                    ),
                  ),
                )
              : const ConnectivityWidget(),
        );
      },
    );
  }

  Widget _bookingDetailTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(icon, size: 20, color: Colors.black54),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "$label: $value",
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void downloadExcelForWeb(List<dynamic> dataList) {
    final excel = Excel.createExcel();
    final Sheet sheet = excel['Pooja Bookings'];

    // Header row
    sheet.appendRow([
      TextCellValue('Name'),
      TextCellValue('Mobile Number'),
      TextCellValue('Pooja Date'),
      TextCellValue('User ID'),
      TextCellValue('Pooja Amount'),
      TextCellValue('Payment Status'),
    ]);

    for (var entry in dataList) {
      sheet.appendRow([
        TextCellValue(entry['name'] ?? ''),
        TextCellValue(entry['mobile'] ?? ''),
        TextCellValue(entry['poojaDate'] ?? ''),
        TextCellValue(entry['id']?.toString() ?? ''),
        TextCellValue(entry['amount']?.toString() ?? ''),
        TextCellValue(entry['paymentStatus'] ?? ''),
      ]);
    }

    final excelBytes = excel.encode();

    final blob = html.Blob([excelBytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "pooja_bookings.xlsx")
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
