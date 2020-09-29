import 'package:flutter_cloud_note/services/base_service.dart';
import 'package:flutter_cloud_note/configs.dart';


class SignUpService {

  final BaseService _baseService = BaseService();
  final Configs _configs = Configs();
  
  String createactivateUserUrl(String uid){
    return _configs.activateUserUrl + '?uid=$uid';
  }

  String createDeleteUserUrl(String uid){
    return _configs.deleteUserUrl + '?uid=$uid';
  }

  Future createUser(Map<String, dynamic> dataMap) async {
    var res = _baseService.basePostRequest(dynamicUrl: _configs.createUserUrl, dataMap: dataMap);
    return res;
  }

}