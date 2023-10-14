import '../utility/network/network_utility.dart';

Future<String> getTranslatedText({required String text, required String target}) async {
  var res = await buildHttpResponse('https://translation.googleapis.com/language/translate/v2', method: HttpMethod.POST, customHeader: {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    'X-goog-api-key': 'AIzaSyCJz71JpM4WkryW0FE7SsEN0ppi2UXCThA'
  }, request: {
    'q': text,
    'target': target,
    'format': 'text'
  });
  /* {
    "data": {
        "translations": [
            {
                "translatedText": "La Gran Pirámide de Giza (también conocida como Pirámide de Keops o Pirámide de Keops) es la más antigua y la más grande de las tres pirámides del complejo piramidal de Giza."
            }
        ]
    }
} */
  return res['data']['translations'][0]['translatedText'];
}
