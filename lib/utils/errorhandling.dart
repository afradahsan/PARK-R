import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess
}) {
  switch(response.statusCode){
    case 200: onSuccess();
    break;
    case 400: debugPrint(jsonDecode(response.body)['msg']);
    break;
    case 500: debugPrint(jsonDecode(response.body)['error']);
    break;
    default: debugPrint(response.body);
  }
}