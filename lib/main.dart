import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localstorage/localstorage.dart';
import 'package:meribiltyapp/Api%20Services/notifications/local_notification_service.dart';
import 'package:meribiltyapp/Api%20Services/registration%20Apis/always_login.dart';
import 'package:meribiltyapp/constants/main_constants.dart';
import 'package:meribiltyapp/screens/authentication/signin.dart';
import 'package:meribiltyapp/screens/authentication/signupcheck.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_deliveries.dart';
import 'package:meribiltyapp/screens/drawer_pages/my_offers.dart';
import 'package:meribiltyapp/screens/home/home.dart';
import 'package:meribiltyapp/screens/onboarding/ask_location.dart';
import 'package:meribiltyapp/screens/onboarding/language_selection.dart';
import 'package:meribiltyapp/screens/onboarding/splashscreen.dart';
import 'package:meribiltyapp/config/firebaseconfig.dart';
import 'package:meribiltyapp/screens/ppl/add_address_info.dart';
import 'package:meribiltyapp/screens/ppl/autocomplete_place_demo.dart';
import 'package:meribiltyapp/screens/ppl/finding_best_qoute.dart';
import 'package:meribiltyapp/screens/ppl/single_bilty_transitfile.dart';
import 'package:meribiltyapp/screens/pro/pro_home.dart';
import 'package:meribiltyapp/services/firebase.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meribiltyapp/widgets/date_time_picker.dart';
import 'package:meribiltyapp/widgets/upload_documents_transit.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  // Dont try to remove print else you are responsible for your own error
  final LocalStorage storage = new LocalStorage('box');
  final LocalStorage chatstorage = new LocalStorage('chatbox');
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  await GetStorage.init();
  await GetStorage.init('box');
  print('me storage hun $storage');
  await storage.getItem("apiToken");
  print(storage.getItem("apiToken"));
  print(storage.getItem("apiToken"));
  await storage.getItem("userType");
  print(storage.getItem("userType"));
  print(storage.getItem("userType"));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'Meribilty-Staging',
      options: DefaultFirebaseConfig.platformOptions);
  await storage.getItem("apiToken") != null ? always_login() : null;
  await storage.getItem('apiToken') != null
      ? Timer.periodic(Duration(minutes: 55), (timer) {
          always_login();
        })
      : null;
  // checkCurrentUser();
  // box.read('apiToken') != null ? always_login : null;
  // box.read('apiToken') != null
  //     ? Timer.periodic(Duration(minutes: 55), (timer) {
  //         always_login();
  //       })
  //     : null;
  // Timer.periodic(Duration(minutes: 55), (t) {
  //   checkCurrentUser();
  //   return t.cancel();
  // });

  print(box.read("token"));

  final client = StreamChatClient(
    'r4vjktd8gbcr',
    logLevel: Level.INFO,
  );
  chatstorage.setItem('chat_client', client);
  print(chatstorage.getItem('chat_client'));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();
    LocalNotificationService.initialize(context);

    // ForeGround
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message);
        print(message.notification!.title);
        print(message.notification!.body);
      }
      LocalNotificationService.display(message);
    });
    //  When the app is in backround but opened and user taps the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data['route'];
      if (message.data['route'] != null) {
        if (message.data['route'] == "tncpage") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) =>
                  FinalOrderCard(orderNo: message.data['orderNo'])));
        }
        if (storage.getItem("apiToken") != null) {
          Navigator.pushNamed(context, routeFromMessage);
        }
      }
      print(routeFromMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        routes: {
          "myOffers": (_) => MyOffers(),
          "MyOrders": (_) => MyDeliveries(),
          // "tncPage": (_) => FindingBestQoute(),
        },
        builder: (context, child) {
          return StreamChat(
            child: child,
            client: chatstorage.getItem('chat_client'),
            streamChatThemeData:
                StreamChatThemeData.fromTheme(Theme.of(context)).copyWith(
              ownMessageTheme: MessageThemeData(
                messageBackgroundColor: Theme.of(context).colorScheme.secondary,
                messageTextStyle: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''), // English, no country code
          Locale('es', ''), // Spanish, no country code
        ],
        debugShowCheckedModeBanner: false,
        // home:
        //  AddAddressInfo(),
        home: storage.getItem("apiToken") == null ? SignIn() : _decideHomePage()
        // SplashScreen()
        // SingleBilty(biltyNo: "222")
        // AutoCompleteDemo()
        // box.read('token') == null ? SignIn() : Home(),
        );
  }

  _decideHomePage() {
    if (storage.getItem("userType") == "user") {
      print("running normal user");
      return Home();
    } else if (storage.getItem("userType") == "pro") {
      print("running Pro user");
      return ProHome();
    } else {
      return SignUpCheck();
    }
  }
}
