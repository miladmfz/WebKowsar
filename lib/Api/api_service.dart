import 'package:dio/dio.dart';
import 'package:kowsarweb/model/AppBrokerCustomer.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

// done this file

@RestApi(baseUrl:'http://87.107.78.234:60005/login') // Enter you base URL
abstract class ApiService {

  factory ApiService(Dio dio, {required String baseUrl}){

    dio.options = BaseOptions(
        receiveTimeout: 30000,
        connectTimeout: 30000,
        contentType: 'application/json',
        /* If needed headers */
        headers: {
          'Authorization': 'Basic ZGlzYXBpdXNlcjpkaXMjMTIz',
          'X-ApiKey': 'ZGslzIzEyMw==',
          'Content-Type': 'application/json'
        }
    );

    return _ApiService(dio,baseUrl:baseUrl);
  }

  // Login service
  @POST('/index.php?tag=GetAppBrokerCustomer') // enter your api method
  Future<List<AppBrokerCustomer>>  getAppBrokerCustomers();


}