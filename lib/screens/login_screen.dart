import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import '../services/kakao_login_service.dart';
import '../widgets/login_view.dart';
import '../widgets/profile_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  User? _user;
  bool _isLoggedIn = false;
  bool _isLoading = false;

  final KakaoLoginService _kakaoService = KakaoLoginService.instance;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  /// 로그인 상태 확인
  Future<void> _checkLoginStatus() async {
    try {
      bool isLoggedIn = await _kakaoService.isLoggedIn();
      if (isLoggedIn) {
        await _getUserInfo();
      }
    } catch (e) {
      print('로그인 상태 확인 실패: $e');
    }
  }

  /// 카카오 로그인 실행
  Future<void> _loginWithKakao() async {
    setState(() {
      _isLoading = true;
    });

    try {
      OAuthToken? token = await _kakaoService.loginWithKakaoTalk();
      
      if (token != null) {
        print('카카오 로그인 성공: ${token.accessToken}');
        await _getUserInfo();
        _showSuccessSnackBar('로그인 성공!');
      } else {
        print('로그인이 취소되었습니다.');
        _showErrorSnackBar('로그인이 취소되었습니다.');
      }
    } catch (error) {
      print('카카오 로그인 실패: $error');
      _showErrorSnackBar('로그인에 실패했습니다. 다시 시도해주세요.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 사용자 정보 가져오기
  Future<void> _getUserInfo() async {
    try {
      User user = await _kakaoService.getUserInfo();
      setState(() {
        _user = user;
        _isLoggedIn = true;
      });
      print('사용자 정보 요청 성공: ${user.kakaoAccount?.profile?.nickname}');
    } catch (error) {
      print('사용자 정보 요청 실패: $error');
      _showErrorSnackBar('사용자 정보를 가져오는데 실패했습니다.');
    }
  }

  /// 로그아웃
  Future<void> _logout() async {
    try {
      await _kakaoService.logout();
      setState(() {
        _user = null;
        _isLoggedIn = false;
      });
      _showSuccessSnackBar('로그아웃되었습니다.');
    } catch (error) {
      print('로그아웃 실패: $error');
      _showErrorSnackBar('로그아웃에 실패했습니다.');
    }
  }

  /// 성공 스낵바 표시
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  /// 에러 스낵바 표시
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "카카오 로그인",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFFEE500),
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: _isLoggedIn 
              ? ProfileView(
                  user: _user,
                  onLogoutPressed: _logout,
                )
              : LoginView(
                  onKakaoLoginPressed: _loginWithKakao,
                  isLoading: _isLoading,
                ),
        ),
      ),
    );
  }
}