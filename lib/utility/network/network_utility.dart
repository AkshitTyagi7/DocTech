import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';

import '../common.dart';
import '../configs.dart';
import 'network_status.dart';

Map<String, String> buildHeaderTokens({bool isStripePayment = false, Map? request}) {
  Map<String, String> header = {
    HttpHeaders.cacheControlHeader: 'no-cache',
    'Access-Control-Allow-Headers': '*',
    'Access-Control-Allow-Origin': '*',
    'Content-Type': 'application/json; charset=UTF-8',
  };

  header.putIfAbsent(HttpHeaders.contentTypeHeader, () => 'application/json; charset=utf-8');
  header.putIfAbsent(HttpHeaders.authorizationHeader, () => 'Bearer $Apptoken');
  header.putIfAbsent(HttpHeaders.acceptHeader, () => 'application/json; charset=utf-8');

  // log(jsonEncode(header));
  return header;
}

Future<Map<String, dynamic>> buildHttpResponse(String endPoint,
    {HttpMethod method = HttpMethod.GET, Map? request, bool isStripePayment = false, Map<String, String>? customHeader}) async {
/*   if (await isNetworkAvailable()) { */
  var headers = buildHeaderTokens(isStripePayment: isStripePayment, request: request);
  Uri url = buildBaseUrl(endPoint);
  log(url);

  Response response;

  if (method == HttpMethod.POST) {
    // log('Request: $request');
    print("--------------------------");
    print(customHeader);
    response = await http.post(
      url,
      body: jsonEncode(request),
      headers: customHeader ?? headers,
      encoding: Encoding.getByName("utf-8"),
    );
  } else if (method == HttpMethod.DELETE) {
    response = await delete(url, headers: headers);
  } else if (method == HttpMethod.PUT) {
    response = await put(url, body: jsonEncode(request), headers: headers);
  } else {
    response = await get(url, headers: headers);
  }

/*     log('Response (${method.name}) ${response.statusCode}: ${response.body}');
 */
  print(response.body);
  return jsonDecode(utf8.decode(response.bodyBytes));
}
/*   else {
    throw 'Your internet is not working';
  } */

Uri buildBaseUrl(String endPoint) {
  Uri url = Uri.parse(endPoint);
  if (!endPoint.startsWith('http')) url = Uri.parse('$BASE_URL$endPoint');

  return url;
}

enum HttpMethod { GET, POST, DELETE, PUT }

Future handleResponse(Response response, [bool? avoidTokenError]) async {
  if (response.statusCode == 401) {
    throw 'Token Expired';
  }

  if (response.statusCode >= 200 && response.statusCode <= 206) {
    return jsonDecode(response.body);
  } else {
    try {
      var body = jsonDecode(response.body);
      throw body['message'];
    } on Exception catch (e) {
      log(e);
      throw 'Something Went Wrong';
    }
  }
}
