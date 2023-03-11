import 'package:flutter/material.dart';
import 'package:quotes_app/intoScreen/first.dart';
import 'package:quotes_app/intoScreen/second.dart';
import 'package:quotes_app/screens/attitude.dart';
import 'package:quotes_app/screens/bravery.dart';
import 'package:quotes_app/screens/confidence.dart';
import 'package:quotes_app/screens/enterpreneur.dart';
import 'package:quotes_app/screens/forgive.dart';
import 'package:quotes_app/screens/home_page.dart';
import 'package:quotes_app/screens/learning.dart';
import 'package:quotes_app/screens/motivational.dart';
import 'package:quotes_app/screens/patience.dart';
import 'package:quotes_app/screens/random.dart';
import 'package:quotes_app/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool? isFirstVisited = prefs.getBool('firstVisited') ?? false;
  bool? isSecondVisited = prefs.getBool('secondVisited') ?? false;
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: (isFirstVisited == false)
          ? 'first'
          : (isSecondVisited == true)
              ? 'splash'
              : 'second',
      routes: {
        'splash': (context) => const SplashScreen(),
        'first': (context) => const First(),
        'second': (context) => const Second(),
        '/': (context) => HomePage(),
        'random': (context) => Random(),
        'patience': (context) => Patience(),
        'forgive': (context) => Forgive(),
        'motivational': (context) => Motivational(),
        'learning': (context) => Learning(),
        'attitude': (context) => Attitude(),
        'bravery': (context) => Bravery(),
        'confidence': (context) => Confidence(),
        'enterprenur': (context) => Enterpreneur(),
      },
    ),
  );
}
