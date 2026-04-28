import 'package:flutter/material.dart';
import 'package:flutter_pjt/routes/app_routes.dart';
import '../../models/trip_destination.dart';
import 'home_grid_item_widget.dart';

class HomeGridWidget extends StatelessWidget{
  List<TripDestination> destinations;
  HomeGridWidget(this.destinations);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //한 줄에 2개씩
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1
        ),
        itemCount: destinations.length,
        itemBuilder: (context, index){ //항목 구성을 위해 자동 호출
          final destination = destinations[index];
          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, AppRoutes.detail, arguments: destination);
            },
            child: HomeGridItem(destination: destination),
          );
        }
    );
  }
}