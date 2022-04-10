import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launch(launchUri.toString());
}

Future<void> sendSms(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'sms',
    path: phoneNumber,
  );
  await launch(launchUri.toString());
}

Future<void> sendMail(String email) async {
  final Uri launchUri = Uri(
    scheme: 'mailto',
    path: email,
  );
  await launch(launchUri.toString());
}
