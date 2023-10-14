import 'dart:convert';
import 'dart:io' show Platform;
/* import 'package:city_star_rap/prefdata/prefdata.dart';
import 'package:city_star_rap/utility/models/user_auth.dart';
import 'package:city_star_rap/utility/network/network_utility.dart'; */
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter/services.dart';

import '../models/user.dart';

import '../pref_data.dart';
import '../routes/app_routes.dart';
import 'common.dart';
import 'network/network_utility.dart';

const REFRESH_TOKEN_KEY = 'refresh_token';
const BACKEND_TOKEN_KEY = 'backend_token';
const GOOGLE_ISSUER = 'https://accounts.google.com';
const GOOGLE_CLIENT_ID_IOS = '772939182035-4ju4igs7tu5nohja6fge23m7oelcleo0.apps.googleusercontent.com';
const GOOGLE_REDIRECT_URI_IOS = 'com.googleusercontent.apps.772939182035-4ju4igs7tu5nohja6fge23m7oelcleo0:/oauthredirect';
const GOOGLE_CLIENT_ID_ANDROID = '772939182035-dku6b6ea4cfo5d61ts2pfh811cjr12lf.apps.googleusercontent.com';
const GOOGLE_REDIRECT_URI_ANDROID = 'com.googleusercontent.apps.772939182035-dku6b6ea4cfo5d61ts2pfh811cjr12lf:/oauthredirect';

String clientID() {
  if (Platform.isAndroid) {
    return GOOGLE_CLIENT_ID_ANDROID;
  } else if (Platform.isIOS) {
    return GOOGLE_CLIENT_ID_IOS;
  }
  return '';
}

String redirectUrl() {
  if (Platform.isAndroid) {
    log(GOOGLE_REDIRECT_URI_ANDROID);
    return GOOGLE_REDIRECT_URI_ANDROID;
  } else if (Platform.isIOS) {
    return GOOGLE_REDIRECT_URI_IOS;
  }
  return '';
}

class AuthService {
  static final AuthService instance = AuthService._();
  factory AuthService() => instance;
  AuthService._();

  final FlutterAppAuth _appAuth = const FlutterAppAuth();

  Future<bool> login(context) async {
    final AuthorizationTokenRequest authorizationTokenRequest;

    try {
      authorizationTokenRequest = AuthorizationTokenRequest(
        clientID(),
        redirectUrl(),
        issuer: GOOGLE_ISSUER,
        scopes: ['email', 'profile'],
      );

      // Requesting the auth token and waiting for the response
      final AuthorizationTokenResponse? result = await _appAuth.authorizeAndExchangeCode(
        authorizationTokenRequest,
      );
      log(result);
      // Taking the obtained result and processing it

      return await _handleAuthResult(context, result);
    } on PlatformException {
      log("User has cancelled or no internet!");
      return false;
    } catch (e) {
      log('erorroror');
      log(e);

      return false;
    }
  }

  Future<bool> logout() async {
    return true;
  }

  Future<bool> _handleAuthResult(BuildContext context, result) async {
    final bool isValidResult = result != null && result.accessToken != null && result.idToken != null;
    if (isValidResult) {
      // Storing refresh token to renew login on app restart
      if (result.refreshToken != null) {}

      final String googleAccessToken = result.accessToken;
      // log(result.toString());
      log(googleAccessToken);
      var response = await buildHttpResponse('user/google_auth', method: HttpMethod.POST, request: {'access_token': googleAccessToken});
/*       var userAuthdata = response['user'];
      log(userAuthdata); */
      log(response['token']);
      await PrefData.setSessionToken(response['token']);
      log("-------------");
/*       await PrefData.setUserauth(jsonEncode(userAuthdata));
 */
      Navigator.popAndPushNamed(context, Routes.homeRoute);
      return true;
    } else {
      return false;
    }
  }
}
