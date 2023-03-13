// import 'package:flutter/material.dart';
//
// import '../../core/play_audio_helper.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class PlayMusicView extends StatefulWidget {
//   const PlayMusicView({Key? key}) : super(key: key);
//
//   @override
//   State<PlayMusicView> createState() => _PlayMusicViewState();
// }
//
// class _PlayMusicViewState extends State<PlayMusicView> {
//   PlayAudioHelper playAudioHelper = PlayAudioHelper();
//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   void show() async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'your channel id', 'your channel name', 'your channel description',
//         importance: Importance.high,
//         sound: RawResourceAndroidNotificationSound('notification_sound'),
//         playSound: true);
//     var androidPlatformChannelSpecifics = AndroidFlutterLocalNotificationsPlugin(sound: 'notification_sound.m4r');
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails(sound: 'notification_sound.m4r');
//     var platformChannelSpecifics =
//         NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'New Notification', 'This is a notification with sound', platformChannelSpecifics,
//         payload: 'item x');
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
//     var initializationSettingsIOS = IOSInitializationSettings();
//     var initializationSettings =
//         InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           IconButton(
//               onPressed: () {
//                 playAudioHelper.play("https://server8.mp3quran.net/ahmad_huth/001.mp3");
//               },
//               icon: Icon(Icons.play_arrow))
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     print("dispose");
//     playAudioHelper.dispose();
//   }
// }
