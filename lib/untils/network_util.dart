import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:renteadmin/untils/sharedpref/shared_prefrence.dart';
import 'sharedpref/preferences.dart';
import 'package:http_parser/src/media_type.dart';
class NetworkUtil {
  //Next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;
  final JsonDecoder _decoder = new JsonDecoder();


  Future<dynamic> get(String url, Map<String, String> headers) {
    return http.get(Uri.parse(url), headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 203 ||
          statusCode == 201 ||
          statusCode == 400 ||
          json == null) {
        //  throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> postApi(String url, {Map? headers, body, encoding}) async {
    return http
        .post(Uri.parse(url),
        body: body,
        headers: {
        //"lang": SessionManager.getString(Preferences.IS_LANGUAGE),
        },
        encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 203 || statusCode == 201 ||
          statusCode == 400 ||
          json == null) {
        //throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }


  Future<dynamic> postSignUpApi(String url, {Map? headers, body, encoding}) async {
    return http
        .post(Uri.parse(url),
        body: body,
        headers: {
         // "lang": SessionManager.getString(Preferences.IS_LANGUAGE),
          "os_version": "flutter",
          "device_token": "232dffdf",
          "app_version": "1.0",
        },
        encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 203 || statusCode == 201 ||
          statusCode == 400 ||  statusCode == 404 ||
          json == null) {
        //throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> postApiWithHeaderLanuage(String url, {Map? headers, body, encoding}) async {
    return http
        .post(Uri.parse(url),
        body: body,
       headers: {
       // "lang": SessionManager.getString(Preferences.IS_LANGUAGE),
        },
        encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 203 ||
          statusCode == 201 ||
          statusCode == 400 ||
          json == null) {
        //throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }
  Future<dynamic> postApiWithHeader(String url, {Map? headers, body, encoding}) async {
    return http
        .post(Uri.parse(url),
        body: body,
        headers: {
          "Authorization": "b "+SessionManager.getString(Preferences.ACCESS_TOKEN),
        },
        encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 203 ||
          statusCode == 201 ||
          statusCode == 400 ||
          json == null) {
        //throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> postWithHeader(String url, {Map? headers, body, encoding}) async {
    return http
        .post(Uri.parse(url),
        body: body,
        headers: {
          "Authorization": "b "+ SessionManager.getString(Preferences.ACCESS_TOKEN),
        },
        encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 203 ||
          statusCode == 201 ||
          statusCode == 400 ||
          json == null) {
        //throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }


  Future<dynamic> post(String url, String auth_token,
      {Map? headers, body, encoding}) {
    return http
        .post(Uri.parse(url),
        body: body,
        headers: {
          "Authorization": auth_token
        },
        encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 203 ||
          statusCode == 201 ||
          statusCode == 400 ||
          json == null) {
        // throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }
  Future<dynamic> multipartApi(String url,
      Map<String, String> headers,
      String category_name,
      List<int>? category_image) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.fields['category_name'] = category_name;
    request.files.add(await http.MultipartFile.fromBytes('category_image', category_image!,
        contentType: new MediaType.parse("image/jpg"),
        filename: "category_image"));
    var res = await request.send();
    var result = await http.Response.fromStream(res);
    request.send().then((response) {
      print("test");
      print(response.statusCode);
      if (response.statusCode == 200) print("Uploaded!");
    });
    return _decoder.convert(result.body);
  }
  Future<dynamic> putApiWithHeader(String url, {Map? headers, body, encoding}) async {
    return http
        .put(Uri.parse(url),
        body: body,
        headers: {
        //  "Authorization": "b ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
        },
        encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 203 ||
          statusCode == 201 ||
          statusCode == 400 ||
          json == null) {
        //throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }
  ///Edit category
  Future<dynamic> editMultipartApi(String url,
      Map<String, String> headers,
      String onBoarding_id,
      String onBoarding_name,
      List<int> category_image,
      String description) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.fields['onBoardingId'] = onBoarding_id;
    request.fields['title'] = onBoarding_name;
    request.fields['description'] = description;
    request.files.add(await http.MultipartFile.fromBytes('image', category_image,
        contentType: new MediaType.parse("image/jpg"),
        filename: "image"));
    var res = await request.send();
    var result = await http.Response.fromStream(res);
    request.send().then((response) {
      print("test");
      print(response.statusCode);
      if (response.statusCode == 200) print("Uploaded!");
    });
    return _decoder.convert(result.body);
  }

  ///Edit Ads
  Future<dynamic> editAdsMultipartApi(String url,
      Map<String, String> headers,
      String ads_id,
      String ads_name,
      List<int> ads_image,
      String description) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.fields['ad_id'] = ads_id;
    request.fields['title'] = ads_name;
    request.fields['url'] = description;
    request.files.add(await http.MultipartFile.fromBytes('image', ads_image,
        contentType: new MediaType.parse("image/jpg"),
        filename: "image"));
    var res = await request.send();
    var result = await http.Response.fromStream(res);
    request.send().then((response) {
      print("test");
      print(response.statusCode);
      if (response.statusCode == 200)
        print("Uploaded!");
    });
    return _decoder.convert(result.body);
  }

  Future<dynamic> NativeAdsMultipartApi(String url,
      Map<String, String> headers,
      String nativeads_name,
      var nativeads_image,
      String adsURL,String filePath) async {
    print(SessionManager.getString(Preferences.ACCESS_TOKEN));
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.fields['title'] = nativeads_name;
    request.fields['url'] = adsURL;
   /*File decodedimgfile = await File("image.jpg").writeAsBytes(nativeads_image);
      var multipartFile = await http.MultipartFile.fromPath("image", decodedimgfile.path,
        contentType: MediaType.parse("image/png"));
          request.files.add(multipartFile);
    print("decodedimgfile ::: "+decodedimgfile.toString());*/
        request.files.add(await http.MultipartFile.fromBytes('image', nativeads_image,
        contentType: new MediaType.parse("image/jpg"),
        filename: filePath));
    var res = await request.send();
    var result = await http.Response.fromStream(res);
    request.send().then((response) {
      print("test");
      print(response.statusCode);
      if (response.statusCode == 200) print("Uploaded!");
    });
    return _decoder.convert(result.body);
  }

}
