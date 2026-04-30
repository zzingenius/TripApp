import 'package:flutter/material.dart';
import 'package:flutter_pjt/services/server_service.dart';
import '../models/trip_destination.dart';

class TripProvider with ChangeNotifier{
  ServerService _serverService = ServerService();
  List<TripDestination> _destinations = [];
  bool _isLoading = false;
  String? _error;

  List<TripDestination> get destination => _destinations;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchDestinations() async{
    _isLoading = true;
    _error = null;

    try{
      _destinations = await _serverService.getDestinationList();
    } catch (e){
      _error = e.toString();
    } finally{
      _isLoading = false;
      notifyListeners();
    }
  }

  //DetailScreen에서 자신의 여행지에 대한 데이터 획득을 위해
  TripDestination? getDestinationById (int id){
    try{
      return _destinations.firstWhere((destination) => destination.id == id);
    }catch(e){
      return null;
    }
  }
}