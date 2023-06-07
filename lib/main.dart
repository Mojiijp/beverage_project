import 'package:beverage_project/page/login_screen.dart';
import 'package:beverage_project/src/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  runApp(const MyApp());
//
//   OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
//   OneSignal.shared.setAppId("2aa54f4f-a694-4e71-a045-806b3c621769");
//   OneSignal.shared
//       .promptUserForPushNotificationPermission(fallbackToSettings: true);
//   OneSignal.shared.sendTag('membership_no', 3);
// // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
//   OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
//     print("Accepted permission: $accepted");
//   });
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: Routes.getPageRoutes(),
      initialRoute: "/login",
    );
  }


}


