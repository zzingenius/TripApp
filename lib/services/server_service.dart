import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_pjt/models/trip_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/trip_destination.dart';

class ServerService {
  String baseUrl = dotenv.env['BASE_URL'] ?? '';

  Future<List<TripDestination>> getDestinationList() async{

    try{
      final response = await http.get(Uri.parse('$baseUrl/destinations'));
      if(response.statusCode == 200){
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((des) => TripDestination.fromJson(des)).toList();
      }else{
        print('error ${response.statusCode}');
        throw Exception('error ${response.statusCode}');
      }

    }catch(e){
      print('server connect error $e');
      throw Exception('server connected fail $e');

    }
  }

  Future<TripInfo> getTripInfo(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/infos/$id'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return TripInfo.fromJson(data);
      } else {
        print('오류 : ${response.statusCode}');
        throw Exception('서버 오류: ${response.statusCode}');
      }
    } catch (e) {
      print('실패 : ${e.toString()}');
      throw Exception('getTripInfo 실패: $e');
    }
  }
}