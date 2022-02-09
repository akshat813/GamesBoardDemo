import 'package:demo/screens/homepage.dart';
import 'package:demo/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo/constants/strings.dart';
import 'package:easy_localization/easy_localization.dart';

bool userLogIn = false;

Future<void> main() async {
  SharedPreferences? prefs;
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();

    prefs = await SharedPreferences.getInstance();
    userLogIn = prefs?.getBool(userLoggedIn)??false;
    print("MAIN-BODY $userLogIn ");
    //print("PREVIOUS CHAT USERS ${previousChatIds.length}");
  }
  catch(e)
  {
    print("Exception $e");
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
  }
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('jp', 'JP')],
      path: 'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp()
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: userLogIn ? const HomePage() : const LoginPage(),
    );
  }
}
