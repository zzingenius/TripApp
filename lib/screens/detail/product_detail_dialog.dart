import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pjt/models/trip_destination.dart';

class ProductDetailDialog extends StatelessWidget {
  TripDestination destination;
  int index;
  ProductDetailDialog(this.index, this.destination);

  static void show(BuildContext context, int index, TripDestination destination){
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0)
        ),
        builder: (context) => SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: ProductDetailDialog(index, destination),
        )
    );
  }
  Widget info(String type){
    IconData? icon;
    String value = '';

    switch (type){
      case '일정' :
        icon = Icons.calendar_month;
        value = ': 1월 1일 ~ 1월 4일 (3박 4일)';
        break;
      case '가격' :
        icon = Icons.attach_money;
        value = ': ${Random().nextInt(130)}만원';
        break;
      case '항공' :
        icon = Icons.flight;
        value = ': 대한항공';
        break;
      case '호텔' :
        icon = Icons.hotel;
        value = ': 전 일정 4성급 이상 호텔';
        break;

    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.blue,),
        SizedBox(width: 3,),
        Text('$type ', style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
        Text(value, style: TextStyle(fontSize: 17),)
      ],
    );
  }
  Widget plan(int day){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7)
          ),
          color: Colors.blue.shade400,

          margin: EdgeInsets.all(13),
          child: Padding(
              padding: EdgeInsets.only(left: 13, top: 8, bottom: 8, right: 13),
              child: Text('$day일차', style: TextStyle(color: Colors.white, fontSize: 17),),
          )
        ),
        Padding(
            padding: EdgeInsets.only(left: 22),
            child: Text(' - 인천공항 출발 (대한항공 KE093, 13:20) ', style: TextStyle(fontSize: 17),),
        ),
        Padding(
          padding: EdgeInsets.only(left: 22),
          child: Text(' - 인천공항 출발 (대한항공 KE093, 13:20) ', style: TextStyle(fontSize: 17),),
        ),
        Padding(
          padding: EdgeInsets.only(left: 22),
          child: Text(' - 인천공항 출발 (대한항공 KE093, 13:20) ', style: TextStyle(fontSize: 17),),
        ),
        SizedBox(height: 10,)
      ],
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

        Expanded(
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
                              info('일정'),
                              SizedBox(height: 8,),
                              info('가격'),
                              SizedBox(height: 8,),

                              info('항공'),
                              SizedBox(height: 8,),

                              info('호텔'),
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

                          ...List.generate(4, (i) => plan(i + 1))

                        ],
                      ),
                  ),

                ],
              ),
            )
        ),
      ],
    ) ;
  }
}