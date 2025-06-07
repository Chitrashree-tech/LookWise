import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '2310f9c42bb1b51a2246288d2e1178b8';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<double?> fetchCurrentTemperature(double lat, double lon) async {
    final url = '$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['main']['temp']?.toDouble();
    } else {
      print('Error fetching weather: ${response.body}');
      return null;
    }
  }
}
