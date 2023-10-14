import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../routes/app_routes.dart';
import '../../pref_data.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PrefData.isLogIn().then((value) {
      if (value) {
        Navigator.popAndPushNamed(context, Routes.homeRoute);
      } else {
        Navigator.popAndPushNamed(context, Routes.login);
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
                padding: const EdgeInsets.only(top: 190),
                child: Image.asset(
                  'assets/logo.png',
                  width: 249,
                  height: 102,
                )),
            Container(
              padding: const EdgeInsets.only(top: 190),
              child: SpinKitCircle(
                color: Theme.of(context).colorScheme.primary,
                size: 80.0,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
