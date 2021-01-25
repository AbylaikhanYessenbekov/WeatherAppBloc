
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_bloc/weather_model.dart';

class NetworkHelper{
  String api = 'b78ae4b705425a396354722cc463dd0f';
  String city;
  String url;
  Future<WeatherModel> getWeather(String cityName) async {
    url = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=b78ae4b705425a396354722cc463dd0f";
    final response = await http.Client().get(url);

    if (response.statusCode != 200)
      throw Exception('You have connection error');
    print(response.statusCode);
    return parsedJSON(response.body);
  }

  WeatherModel parsedJSON(final response) {
    final jsonDecoded = json.decode(response);

    final jsonWeather = jsonDecoded["main"];

    return WeatherModel.fromJson(jsonWeather);
  }

}