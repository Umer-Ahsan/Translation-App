import 'package:api_tutorial/widgets/language_codes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiFunctions {
  // Function to convert a language code to its corresponding name
  static String getLanguageName(String code) {
    return languageCodeToName[code] ??
        'Unknown'; // Default marked as 'Unknown' if language not found
  }

  // Function to convert a language name to its corresponding code
  static String getLanguageCode(String name) {
    for (var entry in languageCodeToName.entries) {
      if (entry.value == name) {
        return entry.key;
      }
    }
    return name;
  }

  //function to fetch data from the api

  static Future<List<String>> fetchLanguages() async {
    final Uri uri = Uri.parse(
        'https://google-translate1.p.rapidapi.com/language/translate/v2/languages');

    final response = await http.get(
      uri,
      headers: {
        'X-RapidAPI-Key': '026388c8acmshabf544a76616d1dp105223jsnb3f9c000e692',
        'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com'
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Checking if data contains languages and it is a List
      if (data.containsKey('data') &&
          data['data'].containsKey('languages') &&
          data['data']['languages'] is List) {
        final List<dynamic> languageData = data['data']['languages'];
        final List<String> languages = languageData
            .map((item) =>
                ApiFunctions.getLanguageName(item['language'].toString()))
            .toList();
        return languages;
      } else {
        throw Exception('Failed to load languages. Invalid data format.');
      }
    } else {
      // print('Error: ${response.statusCode}');
      // print('response body: ${response.body}');
      throw Exception('Failed to load languages');
    }
  }

//function to translate the text

  static Future<String> translateText(
      String text, String sourceLanguageName, String targetLanguageName) async {
    var headers = {
      'Accept-Encoding': 'application/gzip',
      'content-type': 'application/x-www-form-urlencoded',
      'X-RapidAPI-Key': '026388c8acmshabf544a76616d1dp105223jsnb3f9c000e692',
      'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com'
    };

    // Mapping source and target language names to their corresponding codes
    final String sourceLanguageCode =
        ApiFunctions.getLanguageCode(sourceLanguageName);
    final String targetLanguageCode =
        ApiFunctions.getLanguageCode(targetLanguageName);

    var request = http.Request(
        'POST',
        Uri.parse(
            'https://google-translate1.p.rapidapi.com/language/translate/v2'));
    request.bodyFields = {
      'q': text,
      'source': sourceLanguageCode,
      'target': targetLanguageCode,
    };
    request.headers.addAll(headers);
    request.followRedirects = false;

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      // Parse the response to get the translated text
      final Map<String, dynamic> data = json.decode(responseBody);
      if (data.containsKey('data') &&
          data['data'].containsKey('translations')) {
        final List<dynamic> translations = data['data']['translations'];
        if (translations.isNotEmpty) {
          return translations[0]['translatedText'].toString();
        }
      }
    } else {
      // print(response.reasonPhrase);
    }

    throw Exception('Failed to translate text');
  }
}
