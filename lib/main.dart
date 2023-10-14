import 'package:doctech/routes/app_pages.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: AppPages.routes,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 24, 191, 136),
            brightness: Brightness.light,
            primary: Color.fromARGB(255, 24, 191, 136),
            secondary: Color.fromRGBO(53, 56, 63, 1),
            error: Color.fromARGB(255, 24, 191, 136),
            onError: Color.fromARGB(255, 245, 245, 245),
            surface: Colors.black,
            onSurface: Colors.black,
          ),
          // Define the default brightness and colors.
          // brightness: Brightness.light,

          primaryColor: Color.fromARGB(255, 24, 191, 136),
          primaryColorDark: Color.fromRGBO(33, 33, 33, 1),
          // Define the default font family.
          fontFamily: 'Georgia',

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            displayLarge: TextStyle(
                color: Color.fromRGBO(51, 51, 51, 1),
                fontSize: 20,
                letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.bold,
                height: 1),
            titleLarge: TextStyle(
                color: Color.fromRGBO(51, 51, 51, 1),
                fontSize: 18,
                letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.bold,
                height: 1),
            bodyLarge: TextStyle(
                color: Color.fromARGB(255, 245, 245, 245),
                fontSize: 18,
                letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                height: 1),
            bodyMedium: TextStyle(
                color: Colors.black,
                fontSize: 14,
                letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                fontWeight: FontWeight.w400,
                height: 1.1111111111111112),
          ),
        ),
      ),
    );
  }
}
