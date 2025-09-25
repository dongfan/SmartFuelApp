import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  final VoidCallback? onKakaoLoginPressed;
  final bool isLoading;

  const LoginView({
    super.key,
    this.onKakaoLoginPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 2),
        
        // 로고 영역
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: const Color(0xFFFEE500),
            borderRadius: BorderRadius.circular(60),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(
            Icons.chat_bubble_rounded,
            size: 60,
            color: Colors.black,
          ),
        ),
        
        const SizedBox(height: 40),
        
        // 제목
        const Text(
          "카카오 로그인",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        
        const SizedBox(height: 12),
        
        const Text(
          "간편하고 안전하게 로그인하세요",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
        
        const Spacer(flex: 3),
        
        // 로그인 버튼
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: isLoading ? null : onKakaoLoginPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFEE500),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.chat_bubble,
                          size: 16,
                          color: Color(0xFFFEE500),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "카카오로 계속하기",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        
        const SizedBox(height: 16),
        /*
        // 안내 텍스트
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue[100]!),
          ),
          child: const Text(
            "💡 개발 테스트용입니다.\n실제 사용을 위해서는 카카오 개발자 센터에서\n앱 키를 발급받아 설정해야 합니다.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue,
              height: 1.4,
            ),
          ),
        ),
        */
        const Spacer(flex: 1),
      ],
    );
  }
}