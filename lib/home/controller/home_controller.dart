import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:mobile_hris/Config/config.dart';
// import 'package:mobile_hris/services/device_service.dart';
// import 'package:mobile_hris/services/ip_info_api.dart';
// import '../../../services/api_service.dart';

class PermissionController {
  // static final String server = Config.config;
  // static final String serverPhp = Config.configPhp;

  // static Future loadPermissionList(
  //     String token,
  //     int idUser,
  //     int companyid,
  //     String branch,
  //     String startDate,
  //     String endDate,
  //     String page,
  //     String docType) async {
  //   final response = await http.post(
  //     Uri.parse('${server}perijinanmobile/loaddata'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'token': token
  //     },
  //     body: jsonEncode(<String, String>{
  //       'companyid': companyid.toString(),
  //       'branch': branch,
  //       'start_date': startDate,
  //       'end_date': endDate,
  //       'docType': docType,
  //       'page': page,
  //       'user_id': idUser.toString()
  //     }),
  //   );
  //   var jsonObject = json.decode(response.body);
  //   var jsonDetail = jsonObject['data']['data'];
  //   if (jsonObject['status'] == '200') {
  //     if (jsonDetail == "0") {
  //       return null;
  //     } else {
  //       // print(jsonObject);
  //       return jsonObject;
  //     }
  //   } else {
  //     // print("token is not valid");
  //     throw Exception('failed post');
  //   }
  // }

  // static Future loadfilterperizinan(String token) async {
  //   final response = await http.post(
  //     Uri.parse('${server}perijinanmobile/doctype'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'token': token
  //     },
  //   );
  //   var jsonObject = json.decode(response.body);
  //   // print(jsonObject);
  //   return jsonObject;
  // }

  // static Future saveCheckIn(
  //     String token,
  //     int idUser,
  //     int companyid,
  //     String branch,
  //     String date,
  //     String timer,
  //     String fullname,
  //     String latitude,
  //     String longitude,
  //     String nip,
  //     String dataPhoto) async {
  //   // print('ini filenya : $dataPhoto');
  //   var deviceInfo = DeviceInformation();
  //   var dataHp = await deviceInfo.initPlatformState();
  //   var lokasi = Lokasi();
  //   var ipAddress = await getIPAddress();
  //   final String alamatUser =
  //       await lokasi.getAddress(latitude.toString(), longitude.toString());
  //   // print('ip : $ipAddress');
  //   // print('alamat : $alamatUser');
  //   // print('filepath : $dataPhoto');
  //   var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse(
  //           '${serverPhp}index.php/transaction/hris/mobile/Attendancemobile/saveAttendanceIn'));

  //   request.headers.addAll(<String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     'token': token
  //   });
  //   request.fields['branch'] = branch;
  //   request.fields['nip'] = nip;
  //   request.fields['id'] = idUser.toString();
  //   request.fields['companyid'] = companyid.toString();
  //   request.fields['date'] = date;
  //   request.fields['timer'] = timer;
  //   request.fields['latitude'] = latitude;
  //   request.fields['longitude'] = longitude;
  //   request.fields['address'] = alamatUser;
  //   request.fields['fullname'] = fullname;
  //   request.fields['namaBrand'] = dataHp['manufacturer'].toString();
  //   request.fields['model'] = dataHp['model'].toString();
  //   request.fields['systemName'] = dataHp['version.release'].toString();
  //   request.fields['systemVersion'] = dataHp['version.sdkInt'].toString();
  //   request.fields['ip_address'] = ipAddress.toString();
  //   request.fields['token'] = token;
  //   request.files
  //       .add(await http.MultipartFile.fromPath('file_attachment', dataPhoto));
  //   request.fields['namaBrand'] = dataHp['manufacturer'].toString();
  //   request.fields['model'] = dataHp['model'].toString();
  //   request.fields['systemName'] = dataHp['version.release'].toString();
  //   request.fields['systemVersion'] = dataHp['version.sdkInt'].toString();
  //   request.fields['ip_address'] = ipAddress.toString();

  //   http.StreamedResponse response = await request.send();
  //   var responseBytes = await response.stream.toBytes();
  //   var responseString = utf8.decode(responseBytes);
  //   var jsonObj = json.decode(responseString);
  //   // print('\n\n');
  //   // print('RESPONSE WITH HTTP');
  //   // print(responseString);
  //   // print('\n\n');
  //   // print('RESPONSE WITH jsonObj');
  //   // print(jsonObj['data']);
  //   return jsonObj['data'];
  // }

  // static Future saveCheckOut(
  //     String token,
  //     int idUser,
  //     int companyid,
  //     String branch,
  //     String date,
  //     String timer,
  //     String fullname,
  //     String latitude,
  //     String longitude,
  //     String dataPhoto,
  //     String fileOut) async {
  //   // print('ini filenya : $fileOut');
  //   var deviceInfo = DeviceInformation();
  //   var dataHp = await deviceInfo.initPlatformState();
  //   var lokasi = Lokasi();
  //   var ipAddress = await getIPAddress();
  //   final String alamatUser =
  //       await lokasi.getAddress(latitude.toString(), longitude.toString());
  //   // print('ip : $ipAddress');
  //   // print('alamat : $alamatUser');
  //   // print('filepath : $dataPhoto');
  //   var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse(
  //           '${serverPhp}index.php/transaction/hris/mobile/Attendancemobile/saveAttendanceOut'));

  //   request.headers.addAll(<String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     'token': token
  //   });
  //   request.fields['branch'] = branch;
  //   request.fields['id'] = idUser.toString();
  //   request.fields['companyid'] = companyid.toString();
  //   request.fields['date'] = date;
  //   request.fields['timer'] = timer;
  //   request.fields['latitude'] = latitude;
  //   request.fields['longitude'] = longitude;
  //   request.fields['address'] = alamatUser;
  //   request.fields['fullname'] = fullname;
  //   request.fields['fileOut'] = fileOut;
  //   request.fields['namaBrand'] = dataHp['manufacturer'].toString();
  //   request.fields['model'] = dataHp['model'].toString();
  //   request.fields['systemName'] = dataHp['version.release'].toString();
  //   request.fields['systemVersion'] = dataHp['version.sdkInt'].toString();
  //   request.fields['ip_address'] = ipAddress.toString();
  //   request.fields['token'] = token;
  //   request.files
  //       .add(await http.MultipartFile.fromPath('file_attachment', dataPhoto));
  //   request.fields['namaBrand'] = dataHp['manufacturer'].toString();
  //   request.fields['model'] = dataHp['model'].toString();
  //   request.fields['systemName'] = dataHp['version.release'].toString();
  //   request.fields['systemVersion'] = dataHp['version.sdkInt'].toString();
  //   request.fields['ip_address'] = ipAddress.toString();

  //   http.StreamedResponse response = await request.send();
  //   var responseBytes = await response.stream.toBytes();
  //   var responseString = utf8.decode(responseBytes);
  //   var jsonObj = json.decode(responseString);
  //   // print('\n\n');
  //   // print('RESPONSE WITH HTTP');
  //   // print(responseString);
  //   // print('\n\n');
  //   // print('RESPONSE WITH jsonObj');
  //   // print(jsonObj['status']);
  //   return jsonObj['status'];
  // }
}
