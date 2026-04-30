import 'package:flutter_dotenv/flutter_dotenv.dart';
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
}