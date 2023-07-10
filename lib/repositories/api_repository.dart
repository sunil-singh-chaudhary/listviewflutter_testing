import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import '../services/constants.dart';

class ApiRepository {
  Future<List> fetchData() async {
    var url = Uri.parse(Constants.BASE_URL);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List jsonData = jsonDecode(response.body);

        return jsonData;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
        return [];
      }
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
  }
}
