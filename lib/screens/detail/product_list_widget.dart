import 'package:flutter/material.dart';
import 'product_item_widget.dart';
import '../../models/trip_destination.dart';

class ProductListWidget extends StatelessWidget{
  TripDestination destination;
  ProductListWidget(this.destination);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(image: AssetImage(destination.imagePath), fit: BoxFit.cover)
            ),
          ),
          SizedBox(height: 16,),
          Text(destination.description, style: TextStyle(fontSize: 16, color: Colors.black),),

          SizedBox(height: 24,),
          Text('추천 상품', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),

          SizedBox(height: 16,),
          ListView.builder(
              //listView는 자체 스크롤을 지원하기 때문에 개별 스크롤이 아닌 화면 전체 스크롤을 따르게 처리
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index){
                return Card(
                  margin: EdgeInsets.only(bottom: 12),
                  child: ProductItemWidget(index, destination),
                );
              }
          )
        ],
      ),
    );
  }
}