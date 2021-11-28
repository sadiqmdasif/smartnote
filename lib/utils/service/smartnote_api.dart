import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartnote/core/models/config.dart';

const _defaultTimeoutSeconds = 30;

class SmartNoteApi {
  SmartNoteApi({
    required Config config,
  })  : _config = config;


  final Config _config;

  Future<APIResult> authenticate(
    String username,
    String password
  ) async {
    Uri uri = _makeUri('/Account/Login');
    http.Response result;
    try{
      result=await http.post(
      uri,
      body: jsonEncode({'userEmail': username, 'userPassword': password}),
      headers: {'Content-Type': 'application/json'},
    ).timeout(Duration(seconds: _defaultTimeoutSeconds));
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
        body: result.body,
        statusCode: result.statusCode);

    return apiResult;
  }

  Future<APIResult> singup(
      String fname,
      String password,
      String lname,
      String username,
      String email,
      ) async {
    Uri uri = _makeUri('/Account/Register');
    http.Response result;
    try{
      result=await http.post(
        uri,
        body:  jsonEncode({
          "id": 0,
          "createdAt": "2021-11-23T09:52:35.054Z",
          "updatedAt": "2021-11-23T09:52:35.054Z",
          "deletedAt": "2021-11-23T09:52:35.054Z",
          "createdBy": 0,
          "modifiedBy": 0,
          "deletedBy": 0,
          "isDeleted": true,
          "isActive": true,
          "firstName": fname,
          "lastName": lname,
          "roleName": "string",
          "userName": username,
          "userEmail": email,
          "userPassword": password,
          "imageUrl": "string",
          "userPhone": "string",
          "userGroup": "string",
          "userStatus": true,
          "pmsGroupID": 0,
          "groupID": 0,
          "dob": "2021-11-23T09:52:35.055Z"
        }),
        headers: {'Content-Type': 'application/json'},
      ).timeout(Duration(seconds: _defaultTimeoutSeconds));
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
        body: result.body,
        statusCode: result.statusCode);

    return apiResult;
  }


  Future<APIResult> refreshAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? rToken = prefs.getString("RefreshToken");
    String? Token = prefs.getString('Token');
    http.Response response;
    try {
      response = await http.post(
        Uri.parse(
            'https://${_config}/api/Authenticate/RefreshToken'),
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
    print(_makeUri(path));

    var  result= await http.post(
          _makeUri(path, queryParams: queryParams),
          body: jsonEncode(body),
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
    final requester = () => http.put(
          _makeUri(path),
          body:jsonEncode(body),
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
  Uri _makeUri(String path, {Map<String, String?>? queryParams}) {
    if (!path.startsWith('/')) {
      path = '/' + path;
    }
    return Uri.parse(_config.appAPIBase+path);
  }
}

typedef Future<APIResult> APIGetter(String path,
    {Map<String, String> queryParams, int timeoutSeconds});

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
        _data =jsonDecode(body);
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

enum APIResultType { success, connectionProblem, timeout, unauthorized, error }
