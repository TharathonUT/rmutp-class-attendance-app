import 'package:dio/dio.dart';
import 'package:rmutp/backend/class_interfaces.dart';

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
  static Future<UserInfo> getInfo(username) async {
    var response = await Dio().get('http://611224.surachet-r.net/class_attendence/getInfo.php',queryParameters: {"username":username});
    print(response);
    try {
      if(!response.data){
      return new UserInfo();
    }
    } catch (e) {
      print(e);
    }
    return UserInfo.fromJson(response.data);
  }
  static Future<ClassInfoData> getClassInfo(room_number) async {
    var response = await Dio().get('http://611224.surachet-r.net/class_attendence/getRoom.php',queryParameters: {"room_number":room_number});
    print(response);
    try {
      if(!response.data){
      return new ClassInfoData();
    }
    } catch (e) {
      print(e);
    }
    return ClassInfoData.fromJson(response.data);
  }
  static Future<List<Term>> getTerm() async {
    var response = await Dio().get('http://611224.surachet-r.net/class_attendence/getTerm.php');
    print(response);
    List<Term> result_array = [];
    try {
      if(!response.data){
      return [];
    }
    } catch (e) {
      print(e);
    }
    for (var item in response.data) {
      var term = Term.fromJson(item);
      result_array.add(term);
    }
    return result_array;
  }
  static Future<List<DeviceInfo>> getDevice() async {
    var response = await Dio().get('http://611224.surachet-r.net/class_attendence/getDevice.php');
    print(response);
    List<DeviceInfo> result_array = [];
    try {
      if(!response.data){
      return [];
    }
    } catch (e) {
      print(e);
    }
    for (var item in response.data) {
      var device = DeviceInfo.fromJson(item);
      result_array.add(device);
    }
    return result_array;
  }

  static Future<bool> stamp(student_id, room_number) async {
    var data = FormData.fromMap({
      "student_id":student_id,
      "room_number":room_number
    });
    print(data.toString());
    var response = await Dio().post('http://611224.surachet-r.net/class_attendence/timeStamp.php',data: data);
    return response.data;
  }
}