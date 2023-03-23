import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta_transaction/api/api.dart';
import 'package:meta_transaction/util/common_toast.dart';



class DioManager {
  static final DioManager instance = DioManager._internal();

  factory DioManager() => instance;

  static late Dio dio;

  static List<int> codeList = [1002,1003,401,403];

  DioManager._internal() {
    var options = BaseOptions(
      baseUrl: API.BASE_URL,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: getHeaders(),

    );
    dio = Dio(options);
  }

  getHeaders () {
    return {
      'Accept': 'application/json, text/plain, */*',
      'Content-Type': 'application/json;charset=utf8',
    };
  }


  
  Future<Map<String, dynamic>> post(String url, params, Map<String,String> headers,
      [Function? successCallBack, Function? errorCallBack]) async {
    Response? response;
    try {
      response = await dio.post(url, data: params,options: Options(
        headers: headers,
      )) ;
    }catch (error) {
      debugPrint('请求异常: $error');
      if (errorCallBack != null) {
         errorCallBack(error.toString());
      } else {
        return <String, dynamic>{};
      }
    }
    // debugPrint('请求url: $url');
    // debugPrint('返回参数: $response');
    if (response?.statusCode == 200) {
      Map<String, dynamic> dataMap = json.decode(json.encode(response?.data));
      debugPrint(dataMap.toString());
      if (dataMap['state'] == 200) {
        if (successCallBack != null) {
          successCallBack(dataMap['data']);
        } else {
          return dataMap['data'];
        }
      } else {
        if(dataMap['state'] == 1002 ||dataMap['state'] == 1003 || dataMap['state'] == 401){
          CommonToast.showToast("请先登录");
        }
        if (errorCallBack != null) {
          errorCallBack(dataMap['message']);
        } else {
          return <String, dynamic>{};
        }
      }
    } else {
      if (errorCallBack != null) {
        errorCallBack(response.toString());
      } else {
        return <String, dynamic>{};
      }
    }
    return <String, dynamic>{};
  }


  Future<Map<String, dynamic>> get(String url, Map<String,String> queryParams, Map<String,String> headers,
      [Function? successCallBack, Function? errorCallBack]) async {
    Response? response;
    try {
      response = await dio.get(url, queryParameters: queryParams, options: Options(
        headers: headers
      ));
    }  catch (error) {
      debugPrint('请求异常: $error');
      if (errorCallBack != null) {
        errorCallBack(error.toString());
      } else {
        return <String, dynamic>{};
      }
    }
    // debugPrint('请求url: $url');
    // debugPrint('返回参数: $response');
    if (response?.statusCode == 200) {
      Map<String, dynamic> dataMap = json.decode(json.encode(response?.data));
      if (dataMap['state'] == 200) {
        if (successCallBack != null) {
          successCallBack(dataMap['data']);
        } else {
          return dataMap['data'];
        }
      } else {
        if(dataMap['state'] == 1002 || dataMap['state'] == 1003 || dataMap['state'] == 401){
          CommonToast.showToast("请先登录");
        }
        if (errorCallBack != null) {
          errorCallBack(dataMap['message']);
        } else {
          return <String, dynamic>{};
        }
      }
    } else {
      if (errorCallBack != null) {
        errorCallBack(response.toString());
      } else {
        return <String, dynamic>{};
      }
    }
    return <String, dynamic>{};
  }


}
