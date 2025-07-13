import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Utils/widgets/GreetingsCard.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';

Widget programListBuilder(bool isMobile, {required List filteredList}) {
  if (filteredList.isEmpty) {
    return Center(
      child: Card(
        color: Colors.yellow.shade100,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 50,
                color: Colors.orange.shade800,
              ),
              const SizedBox(height: 10),
              Text(
                'No Data Available',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  return ListView.builder(
    // controller: dashCtr.scrollController,
    shrinkWrap: true,
    itemCount: filteredList.length,
    itemBuilder: ((context, index) {
      final card = filteredList[index];
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child:
           GreetingsCard(
            isMobile: isMobile,
            startDate: card?.startDate ?? "",
            endDate: card?.endDate ?? "",
            createdAt: card?.createdAt ?? "",
            name: card?.title ?? "",
            tag: card?.tagList ?? [],
            postType: card?.postType,
            image: card?.postUrl ?? "",
            status: "ACTIVE",
            id: card?.id.toString() ?? '',
            index: index,
            sharedCount: card?.sharedCount ?? 0,
            downloadCount: card?.downloadCount ?? 0,
            isPosition: card?.avatarPostion ?? "",
            isShape: card?.avatarShape ?? "",
            isPinned: card?.isPinned ?? false,
          )
      );
    }),
  );
}
