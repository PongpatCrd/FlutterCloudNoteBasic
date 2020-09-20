import 'package:flutter_cloud_note/services/base_service.dart';
import 'package:flutter_cloud_note/configs.dart';

class HelperService {
  
  final BaseService _baseService = BaseService();
  final Configs _configs = Configs();

  Future sendEmail(Map<String, dynamic> dataMap) async {
    var res = _baseService.basePostRequest(dynamicUrl: _configs.sendEmailUrl, dataMap: dataMap);
    return res;
  }
}