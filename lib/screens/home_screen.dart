import 'package:flutter/material.dart';
import 'package:flutter_pjt/providers/trip_provider.dart';
import 'package:flutter_pjt/screens/home/home_drawer_widget.dart';
import 'package:flutter_pjt/screens/home/home_grid_widget.dart';
import 'package:flutter_pjt/screens/home/home_middle_widget.dart';
import 'package:flutter_pjt/screens/home/home_top_widget.dart';
import 'package:flutter_pjt/services/shared_prefs_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen>{
  bool _isSearching = false;
  List<String> _searchHistory = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }
  void _changeSearchingStatus(){
    setState(() {
      _isSearching = !_isSearching;
    });
  }
  Future<void> _loadHistory() async {
    final history = await SharedPrefsService.instance.loadHistory();
    setState(() {
      _searchHistory = history;
    });
  }

  Future<void> _save(String query) async {
    if(query.isEmpty) return;

    _searchHistory.add(query);
    _changeSearchingStatus();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching? TextField(
          decoration: InputDecoration(
              hintText: '검색어를 입력하세요'
          ),
          onSubmitted: (input){
            if(input.trim().isEmpty) {
              _changeSearchingStatus();
            } else {
              _save(input);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('검색어 $input'))
              );
            }
          },
        )
            : Text('Trip App'),
        actions: _isSearching? [
          IconButton(onPressed: _changeSearchingStatus, icon: Icon(Icons.close))
        ]
            : [
          IconButton(onPressed: _changeSearchingStatus, icon: Icon(Icons.search)),
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
        ],
      ),
      drawer: HomeDrawerWidget(),
      body: Column(
        children: [
          HomeTopWidget(),
          Expanded(
              child: Padding(
                padding: EdgeInsetsGeometry.all(16),
                child: Column(
                  children: [
                    HomeMiddleWidget(),
                    SizedBox(height: 16,),

                    //상위 어딘가에 추가된 앱의 상태 데이터 획득
                    Expanded(
                        child: Consumer<TripProvider>(
                            builder: (context, tripProvider, child){
                              return HomeGridWidget(tripProvider.destination);
                            }
                        )
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}

