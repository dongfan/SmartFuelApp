import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'screens/login_screen.dart';

void main() {
  // 카카오 SDK 초기화
  KakaoSdk.init(
    nativeAppKey: 'e3cdde95ba02edf430f38f688e02e0ed', // 실제 네이티브 앱 키
    javaScriptAppKey: 'bc562e3c3555eef9ec1d6e51b0016b3c', // JavaScript 키가 다르다면 별도로 설정
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kakao Login Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFEE500), // 카카오 옐로우
        ),
        useMaterial3: true,
        fontFamily: 'NotoSansKR', // 한글 폰트 (옵션)
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
