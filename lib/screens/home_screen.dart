import 'package:flutter/material.dart';
import 'package:flutter_pjt/screens/home/home_top_widget.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip App'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search)),
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
        ],
      ),
      body: Column(
        children: [
          HomeTopWidget()
        ],
      ),
    );
  }

}