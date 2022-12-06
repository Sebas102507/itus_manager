// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itus_manager/app.dart';
import 'package:http/http.dart' as http;
import 'package:itus_manager/services/auth_service.dart';
import 'package:logger/logger.dart';

void main() {

  setUpAll(() {
    HttpOverrides.global = null;
  });


  test('http unit-test works', () async {
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse('https://api.ipify.org/'));
    var response = await request.close();
    print('BODY: $response');
  });



}
