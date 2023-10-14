import 'package:doctech/constants/colors.dart';
import 'package:doctech/utility/google_auth.dart';
import 'package:doctech/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoading
          ? Center(
              child: SpinKitCircle(
                color: Theme.of(context).primaryColor,
                size: 80.0,
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 30),
                      child: Image.asset(
                        'assets/logo.png',
                        width: 180,
                      )),
                  Container(
                    padding: EdgeInsets.only(top: 50),
                    child: RichText(
                      text: TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'Welcome to ', style: TextStyle(fontWeight: FontWeight.w500)),
                          TextSpan(
                            text: 'DocTech 👋',
                            style: TextStyle(color: theme, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                  xLargeSpace(),
                  Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  mediumSmallSpace(),
                  Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  mediumSpace(),
                  Container(
                      width: MediaQuery.of(context).size.width - 60,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: theme,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Log in',
                            style: TextStyle(fontSize: 20),
                          ))),
                  largeSpace(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          /*           onTap: () async {
                            bool isLogin = await signinwithfacebook();
                            if (isLogin) {
                              Navigator.popAndPushNamed(context, Routes.home);
                            }
                          }, */
                          child: Image.asset('assets/icons/facebook.png')),
                      Container(
                          padding: EdgeInsets.only(
                            left: 80,
                          ),
                          child: GestureDetector(
                              onTap: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                await AuthService().login(context);
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              child: Image.asset('assets/icons/Google.png'))),
                    ],
                  )
                ],
              ),
            ),
    ));
  }
}
