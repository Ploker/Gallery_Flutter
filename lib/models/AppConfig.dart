import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {
  final String apiUrl;
  final String clientId;
  
  AppConfig({this.apiUrl, this.clientId});

   static Future<AppConfig> forEnvironment() async {

    final contents = await rootBundle.loadString(
      'assets/config/unsplash.json',
    );

    final json = jsonDecode(contents);

    return AppConfig(apiUrl: json['apiUrl'], clientId: json['clientId']);
  }
}