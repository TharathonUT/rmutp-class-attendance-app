import 'package:dio/dio.dart';

class UserService {
  static Future<bool> login(username, password) async {
    var data = FormData.fromMap({
      "username":username,
      "password":password
    });
    print(data);
    var response = await Dio().post('http://611224.surachet-r.net/class_attendence/login.php',data: data);
    print(response);
    return response.data;
  }
  static Future<dynamic> getInfo(username) async {
    var response = await Dio().get('http://611224.surachet-r.net/class_attendence/getInfo.php',queryParameters: {"username":username});
    print(response);
    return response.data;
  }
  static Future<dynamic> getClassInfo(room_number) async {
    var response = await Dio().get('http://611224.surachet-r.net/class_attendence/getRoom.php',queryParameters: {"room_number":room_number});
    print(response);
    return response.data;
  }
}