import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartnote/core/models/config.dart';

const _defaultTimeoutSeconds = 30;

class SmartNoteApi {
  SmartNoteApi({
    required Config config,
    http.Client? client,
  })  : _config = config,
        this.client = client ?? http.Client();

  // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @visibleForTesting
  APIUser? apiUser;

  final Config _config;

  @visibleForTesting
  http.Client client;

  @visibleForTesting
  String accessToken = '';

  @visibleForTesting
  String refreshToken = '';


  Future authenticate(
    String username,
    String password,
  ) async {
    Uri uri = _makeUri('/Account/Login');
    var result=await client.post(
      uri,
      body: jsonEncode({'userEmail': username, 'userPassword': password}),
      headers: {'Content-Type': 'application/json'},
    );
    print(result.body);

  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUser = null;
    prefs.remove('Token');
    prefs.remove('RefreshToken');
    prefs.remove('userID');
    prefs.remove('firstName');
    prefs.remove('lastName');
    prefs.remove('userName');
    prefs.remove('role');
    client.close();
  }

  Future<APIResult> refreshAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? rToken = prefs.getString("RefreshToken");
    String? Token = prefs.getString('Token');

    //  var uri = _makeUri('/api/Authenticate/RefreshToken');
    http.Response response;
    try {
      response = await client.post(
        Uri.parse(
            'https://${_config.apApiDomain}/api/Authenticate/RefreshToken'),
        body: {
          'Token': Token,
          'RefreshToken': rToken,
        },
      ).timeout(
        Duration(seconds: _defaultTimeoutSeconds),
      );
    } on SocketException {
      return APIResult(type: APIResultType.connectionProblem);
    } on TimeoutException {
      return APIResult(type: APIResultType.timeout);
    } catch (err) {
      return APIResult(type: APIResultType.error, errors: {
        "general": [err.toString()]
      });
    }

    var apiResult = APIResult(
        type: APIResultType.success,
        body: response.body,
        statusCode: response.statusCode);

    if (response.statusCode == 200) {
      var data = apiResult.data;
      print(data['token']);

      await prefs.setString("Token", data['token']);
      await prefs.setString("RefreshToken", data['refreshToken']);
      // return apiResult;
    } else {
      // accessToken = '';
      prefs.setString("Token", 'N/A');
      // refreshToken = '';
      prefs.setString("RefreshToken", 'N/A');

      logout();
    }

    return apiResult;
  }

  Future get(String path,
      {Map<String, String?>? queryParams,
      int timeoutSeconds = _defaultTimeoutSeconds}) async {
    var uri = _makeUri(path, queryParams: queryParams);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('Token') ?? '';
    final requester =
        () => http.get(uri, headers: {'Authorization': 'Bearer ' + token});

    // TODO: log requests when in debug mode
    // print('Getting $path with ${queryParams.toString()}');
  }

  Future post(String path,
      {Object? body,
      Map<String, String?>? queryParams,
      int timeoutSeconds = _defaultTimeoutSeconds}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('Token') ?? '';

    var  result= await client.post(
          _makeUri(path, queryParams: queryParams),
          body: convert.jsonEncode(body),
          headers: {
            'Authorization': 'Bearer ' + token,
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );
    print(result.body);
  }

  Future put(String path,
      {required Object body,
      int timeoutSeconds = _defaultTimeoutSeconds}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('Token') ?? '';
    final requester = () => client.put(
          _makeUri(path),
          body: convert.jsonEncode(body),
          headers: {
            'Authorization': 'Bearer ' + token,
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );
  }

  Future<APIResult> uploadMultipart(
      {required String path,
      required Uint8List bytes,
      required String filename}) async {
    var url = _makeUri(path);
    final requester = http.MultipartRequest('POST', Uri.parse(url.toString()));
    print(url);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('Token') ?? '';

    requester.files.add(
      http.MultipartFile.fromBytes(
        'file',
        bytes,
        contentType: MediaType('image', 'jpg'),
        filename: filename,
      ),
    );
    Map<String, String> headers = {
      'Authorization': 'Bearer ' + token,
    };

    requester.headers.addAll(headers);
    http.StreamedResponse response = await requester.send();

    final res = await http.Response.fromStream(response);

    return APIResult(
      type: res.statusCode < 400 ? APIResultType.success : APIResultType.error,
      statusCode: res.statusCode,
      body: res.body,
    );
  }

  Future<APIResult> uploadMultipartFromPath(
      {required String path,
      required String filePath,
      required String filename}) async {
    var url = _makeUri(path);
    final requester = http.MultipartRequest('POST', Uri.parse(url.toString()));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('Token') ?? '';
    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('file', filePath);
    requester.files.add(multipartFile);
    Map<String, String> headers = {
      'Authorization': 'Bearer ' + token,
    };

    requester.headers.addAll(headers);
    http.StreamedResponse response = await requester.send();

    final res = await http.Response.fromStream(response);

    return APIResult(
      type: res.statusCode < 400 ? APIResultType.success : APIResultType.error,
      statusCode: res.statusCode,
      body: res.body,
    );
  }

  Uri _makeUri(String path, {Map<String, String?>? queryParams}) {
    if (!path.startsWith('/')) {
      path = '/' + path;
    }
    if (_config.apApiPort == null) {
      return Uri.https(
          _config.apApiDomain, _config.apApiBasePath + path, queryParams);
    } else {
      return Uri(
        scheme: 'http',
        host: _config.apApiDomain,
        port: _config.apApiPort,
        path: _config.apApiBasePath + path,
        queryParameters: queryParams,
      );
    }
  }
}

typedef Future<APIResult> APIGetter(String path,
    {Map<String, String> queryParams, int timeoutSeconds});

// Used for controlling the fetching of multiple pages of results, with the
// ability to cancel the fetching.
class APIPageFetcher {
  APIPageFetcher({
    required APIGetter getter,
    required String path,
    Map<String, String>? queryParams,
    int? limitPerPage,
    DateTime? updatedSince,
  }) {
    _getAllPages(
        getter: getter,
        path: path,
        queryParams: queryParams,
        limitPerPage: limitPerPage,
        updatedSince: updatedSince);
  }

  StreamController<APIResult>? _streamController;
  var _isCancelled = false;

  Stream<APIResult>? get stream {
    return _streamController?.stream;
  }

  void cancelFetching() {
    _isCancelled = true;
    _streamController?.close();
  }

  void _getAllPages({
    required APIGetter getter,
    required String path,
    Map<String, String>? queryParams,
    int? limitPerPage,
    DateTime? updatedSince,
  }) async {
    _streamController = StreamController<APIResult>();
    queryParams ??= {};
    limitPerPage ??= 100;

    if (updatedSince != null) {
      queryParams['updated_since'] = updatedSince.toUtc().toIso8601String();
    }

    var page = 0;
    var errorCount = 0;
    var fetching = true;

    while (fetching && !_isCancelled) {
      // Allow up to 2 retries before giving up and returning an error result
      if (errorCount > 2) {
        break;
      }

      if (errorCount > 0) {
        print('FETCHED FAILED for page ${page.toString()} of $path');

        // Pause briefly before retrying
        await Future.delayed(Duration(seconds: errorCount));
      } else {
        page += 1;

        // TODO: Add conditional logging for debug mode
        print('Fetching page ${page.toString()} of $path');
      }

      var result = await getter(path, queryParams: {
        ...queryParams,
        'page': page.toString(),
        'limit': limitPerPage.toString(),
      });

      if (result.type != APIResultType.success) {
        errorCount += 1;
        continue;
      }

      var payload = result.data['payload'];

      if (payload == null || payload.length == 0) {
        _streamController?.close();
      }

      if (!_isCancelled) {
        _streamController?.sink.add(result);
      }
    }

    _streamController?.addError(APIResult(type: APIResultType.error));
  }
}

class APIResult {
  APIResult(
      {required this.type,
      this.body = '',
      Map<String, List<String>>? errors,
      this.statusCode = 0})
      : this._errors = errors ?? Map<String, List<String>>();

  final APIResultType type;
  final String body;
  final Map<String, List<String>> _errors;
  final int statusCode;

  Map<String, dynamic>? _data;

  Map<String, dynamic> get data {
    if (_data == null) {
      try {
        _data = convert.jsonDecode(body);
      } catch (err) {
        _data = {};
      }
    }
    return _data!;
  }

  Map<String, List<String>> get errors {
    if (_errors.length == 0) {
      try {
        data['errors']?.entries?.forEach((MapEntry entry) {
          if (_errors[entry.key] == null) {
            _errors[entry.key] = <String>[];
          }
          entry.value?.forEach((error) => _errors[entry.key]?.add(error));
        });
      } catch (ex) {
        print('Problem parsing errors on response data: $ex');
      }
    }

    return _errors;
  }

  List<String> get errorsList {
    return errors.values.expand((x) => x).toList();
  }
}

class APIUser {
  APIUser(
      {required this.userID,
      required this.firstName,
      required this.lastName,
      required this.userName,
      required this.role});

  int userID;
  String firstName;
  String lastName;
  String userName;
  String role;
}

enum APIResultType { success, connectionProblem, timeout, unauthorized, error }
