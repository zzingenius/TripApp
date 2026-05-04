class TripInfo {
  int id;
  String days;
  String price;
  String flight;
  String hotel;
  List<DayDetail> details;

  TripInfo({
    required this.id,
    required this.days,
    required this.price,
    required this.flight,
    required this.hotel,
    required this.details,
  });

  factory TripInfo.fromJson(Map<String, dynamic> json){
    return TripInfo(
        id: json['id'],
        days: json['days'],
        price: json['price'],
        flight: json['flight'],
        hotel: json['hotel'],
        details: (json['details'] as List)
            .map((d) => DayDetail.fromJson(d))
            .toList(),
    );
  }

}

class DayDetail{
  String day;
  List<String> info;

  DayDetail({ required this.day, required this.info});

  factory DayDetail.fromJson(Map<String, dynamic> json) {
    return DayDetail(
      day: json['day'],
      info: List<String>.from(json['info']),
    );
  }
}