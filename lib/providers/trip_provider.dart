import 'package:flutter/material.dart';
import 'package:flutter_pjt/services/server_service.dart';
import '../models/trip_destination.dart';

class TripProvider with ChangeNotifier{
  ServerService _serverService = ServerService();
  List<TripDestination> _allDestinations = [];
  List<TripDestination> _filterDestinations = [];
  bool _isLoading = false;
  String? _error;

  List<TripDestination> get destination => _filterDestinations;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchDestinations() async{
    _isLoading = true;
    _error = null;

    try{
      _allDestinations = await _serverService.getDestinationList();
      _filterDestinations = _allDestinations;
    } catch (e){
      _error = e.toString();
    } finally{
      _isLoading = false;
      notifyListeners();
    }
  }
  void filterDestination(String query){
    if(query.trim().isEmpty){
      _filterDestinations = _allDestinations;
    }else{
      _filterDestinations = _allDestinations.where((d) => d.name.contains(query)).toList();
    }
    notifyListeners();
  }

  void clearFilter(){
    _filterDestinations = _allDestinations;
    notifyListeners();
  }
  //DetailScreen에서 자신의 여행지에 대한 데이터 획득을 위해
  TripDestination? getDestinationById (int id){
    try{
      return _allDestinations.firstWhere((destination) => destination.id == id);
    }catch(e){
      return null;
    }
  }
}