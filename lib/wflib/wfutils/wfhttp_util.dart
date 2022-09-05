// Copyright 2020 The WiseCom Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WFHttpUtil {
  static bool _bShowProgressDialog = true;
  static String _token = "";
  static void setToken(String strToken) {
    _token = strToken;
  }

  static Future<dynamic> get(String strUrl,
      {Map<String, String>? headers, context}) async {
    try {
      // 프로그래스 다이알로그 체크
      if (context != null) showLoaderDialog(context);

      final url = Uri.parse(strUrl);
      final response = await http.get(url, headers: headers);

      // 프로그래스 다이알로그 체크
      if (context != null) Navigator.pop(context);

      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        return json.decode(res);
      } else {
        return _errorMsg(res, statusCode);
      }
    } catch (e) {
      return _errorMsg(e.toString(), -111);
    }
  }

  static Future<dynamic> post(String strUrl, {body, encoding, context}) async {
    try {
      // 프로그래스 다이알로그 체크
      if (_bShowProgressDialog) showLoaderDialog(context);

      final url = Uri.parse(strUrl);
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_token',
      };
      if (body != null) {
        body = json.encode(body);
      }
      final response = await http.post(url,
          body: body, headers: requestHeaders, encoding: encoding);

      // 프로그래스 다이알로그 체크
      if (_bShowProgressDialog) Navigator.pop(context);

      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        return json.decode(res);
      } else {
        //(statusCode == 201) 에러는 검토해봐야함
        return _errorMsg(res, statusCode);
      }
    } catch (e) {
      return _errorMsg(e.toString(), -111);
    }
  }

  // errorMsg 메시지가 json 형태일때 에러 발생함
  static dynamic _errorMsg(String errorMsg, int statusCode) {
    try {
      Map errorMap = json.decode(errorMsg);
      errorMap['errorcode'] = '-100';
      errorMap['statusCode'] = statusCode;
      return errorMap;
    } catch (e) {
      print('_errorMsg exception=${e.toString()}');
      return json
          .decode('{"errorcode": "-100", "error": "errorMsg exception"}');
    }
  }

  static dynamic checkSucess(dynamic response) {
    try {
      if (response == null) {
        return false;
      }

      if (response['errorcode'] != null) {
        return false;
      }
      return true;
    } catch (e) {
      return true;
    }
  }

  static showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
