import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pjt/models/trip_destination.dart';
import 'package:flutter_pjt/models/trip_info.dart';
import 'package:flutter_pjt/providers/trip_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailDialog extends StatelessWidget {
  TripDestination destination;
  int index;
  int id;

  ProductDetailDialog(this.index, this.destination, this.id);

  static void show(BuildContext context, int index, TripDestination destination, int id){
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0)
        ),
        builder: (context) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: ProductDetailDialog(index, destination, id),
        )
    );
  }
  Widget info(String type, String value){
    IconData? icon;

    switch (type){
      case '일정' :
        icon = Icons.calendar_month;
        break;
      case '가격' :
        icon = Icons.attach_money;
        break;
      case '항공' :
        icon = Icons.flight;
        break;
      case '호텔' :
        icon = Icons.hotel;
        break;

    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.blue,),
        SizedBox(width: 3,),
        Text('$type ', style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
        Text(': $value', style: TextStyle(fontSize: 17),)
      ],
    );
  }
  Widget plan(List<DayDetail> details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: details.expand((detail) => [
        Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7)
            ),
            color: Colors.blue.shade400,
            margin: EdgeInsets.all(13),
            child: Padding(
              padding: EdgeInsets.only(left: 13, top: 8, bottom: 8, right: 13),
              child: Text(detail.day,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            )
        ),
        ...detail.info.map((infoItem) =>
            Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text(' - $infoItem', style: TextStyle(fontSize: 17)),
            )
        ),
        SizedBox(height: 10),
      ]).toList(),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 22, bottom: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${destination.name} 여행 상품 ${index + 1}',style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text('닫기', style: TextStyle(color: Colors.blue, fontSize: 17, fontWeight: FontWeight.bold),),
                )
              ],
            ),
        ),
        Consumer<TripProvider>(
            builder: (context, tripProvider, child){
              if(tripProvider.isInfoLoading){
                return Center(child: CircularProgressIndicator(),);
              }
              if(tripProvider.infoError != null){
                return Center(
                  child: Column(
                    children: [
                      Icon(Icons.error, size: 64, color: Colors.red,),
                      SizedBox(height: 16,),
                      Text('오류가 발생했습니다. \n ${tripProvider.infoError}'),
                      SizedBox(height: 16,),
                      ElevatedButton(onPressed: ()=> tripProvider.fetchTripInfo(id), child: Text('다시시도'))
                    ],
                  )
                );
              }
              if(tripProvider.tripInfo == null){
                return Text('일정을 불러올 수 없습니다.');
              }

              return Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 130,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage(destination.imagePath), fit: BoxFit.cover)
                          ),
                        ),
                        Center(
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              color: Colors.blue.shade50,
                              margin: EdgeInsets.all(13),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    info('일정', tripProvider.tripInfo!.days),
                                    SizedBox(height: 8,),
                                    info('가격', tripProvider.tripInfo!.price),
                                    SizedBox(height: 8,),

                                    info('항공', tripProvider.tripInfo!.flight),
                                    SizedBox(height: 8,),

                                    info('호텔', tripProvider.tripInfo!.hotel),
                                  ],
                                ),
                              )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('상세 일정', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                              plan(tripProvider.tripInfo!.details)

                            ],
                          ),
                        ),

                      ],
                    ),
                  )
              );
            }
        ),


      ],
    ) ;
  }
}