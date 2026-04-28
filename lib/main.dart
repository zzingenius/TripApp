import 'package:flutter/material.dart';
import 'package:flutter_pjt/models/trip_destination.dart';
import 'package:flutter_pjt/providers/news_provider.dart';
import 'package:flutter_pjt/providers/trip_provider.dart';
import 'package:flutter_pjt/providers/user_provider.dart';
import 'package:flutter_pjt/screens/about_screen.dart';
import 'package:flutter_pjt/screens/detail_screen.dart';
import 'package:flutter_pjt/screens/myinfo_screen.dart';
import 'package:provider/provider.dart';
import './routes/app_routes.dart';
import './screens/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  //constant constructor, const 예약어로 생성 -> 필수는 아니지만 위젯에서 권장사항
  //동일 매개변수로 객체 재사용 => 위젯은 불변이기 때문
  runApp(const TripApp());
}

class TripApp extends StatelessWidget{
  //모든 위젯은 키를 가질 수 있다.
  // const TripApp({super.key});
  const TripApp();

  @override
  Widget build(BuildContext context) {
    //테마 설정 + 라우팅 등록 + 앱 전역 상태 등록
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TripProvider(),),
        //.. =>UserProvider를 등록하면서 함수 한 번만 호출하겠다
        ChangeNotifierProvider(create: (_) => UserProvider()..loadUserData()),
        ChangeNotifierProvider(create: (_) => NewsProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        debugShowCheckedModeBanner: false, //디버그 띠 제거
        initialRoute: AppRoutes.home,
        routes: {
          AppRoutes.home: (context) => HomeScreen(),
          AppRoutes.about: (context) => AboutScreen(),
          AppRoutes.myInfo: (context) => MyinfoScreen(),
        },
        onGenerateRoute: (settings){
          if(settings.name == AppRoutes.detail){
            final destination = settings.arguments as TripDestination;
            return MaterialPageRoute(
              builder: (context) => DetailScreen(destination)
            );
          }
          return null;
        },
      ),
    );
  }

}