import 'package:flutter_cloud_note/services/base_service.dart';
import 'package:flutter_cloud_note/configs.dart';


class SignUpService {

  final BaseService _baseService = BaseService();
  final Configs _configs = Configs();
  
  String createActiveUserUrl(String uid){
    return _configs.activeUserUrl + '?uid=$uid';
  }

  Future createUser(Map<String, dynamic> dataMap) async {
    var res = _baseService.basePostRequest(dynamicUrl: _configs.createUserUrl, dataMap: dataMap);
    return res;
  }

  Future activeUser(Map<String, dynamic> dataMap) async {    
    var res = _baseService.basePutRequest(dynamicUrl: _configs.activeUserUrl, dataMap: dataMap);
    return res;
  }
}