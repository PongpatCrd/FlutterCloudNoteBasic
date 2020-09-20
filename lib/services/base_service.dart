import 'dart:convert' as convert;
import 'package:http/http.dart';

class BaseService {

  Future baseGetRequest({String dynamicUrl, Map<String, dynamic> dataMap}) async {
    Response res = await get(
      dynamicUrl,
      headers: dataMap
    );

    return convert.jsonDecode(res.body);
  }

  // create new resource
  Future basePostRequest({String dynamicUrl, Map<String, dynamic> dataMap}) async {
    Response res = await post(
      dynamicUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(dataMap),
    );

    return convert.jsonDecode(res.body);
  }

  // create update resource
  Future basePutRequest({String dynamicUrl, Map<String, dynamic> dataMap}) async {
    Response res = await put(
      dynamicUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(dataMap),
    );

    return convert.jsonDecode(res.body);
  }
}