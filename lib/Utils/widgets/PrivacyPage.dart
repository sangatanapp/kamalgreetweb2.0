import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                'Postकरो! Privacy Policy',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              )),
              SizedBox(height: 20),
              Text(
                'ABOUT US:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Postकरो! recognizes how important it is to keep your information private. Thank you for putting your trust in us; we respect your privacy. The handling of user data gathered from Postकरो! and other offline sources is described in this policy. This privacy statement is applicable to both present and previous users of our online store and app. By using our app or visiting and/or using our website, you consent to our privacy policy.',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'Data Security:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We implement appropriate technical and organizational measures to protect the security of your personal information. However, please note that no security measures are 100% foolproof, and we cannot guarantee the absolute security of your information.',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10),
              Text(
                'We retain your personal information for as long as necessary to fulfill the purposes outlined in this privacy policy, unless a longer retention period is required or permitted by law.',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10),
              Text(
                'Our application is not intended for use by individuals under the age of 13. We do not knowingly collect personal information from children under 13. If we become aware that we have collected personal information from a child under 13 without parental consent, we will take steps to remove the information promptly.',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'Information We Collect:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We may collect personal information that you voluntarily provide to us when using the application, such as your name, email address, contact number, and other identifying information. This information is used to create your profile on the app. We may ask you for your permission to upload photos, videos, and other file formats on the app. This is to enable you to set up your profile picture, upload posts, and send notifications on the app.',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'Your Rights',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'You have the right to access, correct, or delete your personal information held by us. You can exercise these rights by contacting us using the contact information provided below.',
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                ' In addition, you have the option to request information about how your personal data is processed. In response, we will tell you about the reasons behind the processing, the types of personal data that are processed, and the recipients of the data.',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'Jurisdiction:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'If you choose to visit the website, your visit and any dispute over privacy are subject to this policy and the website\'s terms of use. In addition to the foregoing, any disputes arising under this policy shall be governed by the laws of India.',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'Contact Us:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'If you have any questions, concerns, or requests regarding this privacy policy or the privacy practices of the application, please contact us at:',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10),
              Text(
                'Flat NO. B-1, G02, SECTOR 89, GURGAON, NBCC Apartments, Tulip Ace, Garhi Harsaru, Gurugram, Haryana, 122505',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Email: postkaro20@gmail.com',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
