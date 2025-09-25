import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class ProfileView extends StatelessWidget {
  final User? user;
  final VoidCallback? onLogoutPressed;

  const ProfileView({
    super.key,
    required this.user,
    this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 1),
        
        // 프로필 카드
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              // 프로필 이미지
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFFFEE500),
                    backgroundImage: user?.kakaoAccount?.profile?.profileImageUrl != null
                        ? NetworkImage(user!.kakaoAccount!.profile!.profileImageUrl!)
                        : null,
                    child: user?.kakaoAccount?.profile?.profileImageUrl == null
                        ? const Icon(Icons.person, size: 50, color: Colors.black)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // 환영 메시지
              const Text(
                "로그인 완료! 🎉",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // 닉네임
              Text(
                "${user?.kakaoAccount?.profile?.nickname ?? '사용자'}님",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              
              const SizedBox(height: 12),
              
              // 이메일
              if (user?.kakaoAccount?.email != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.email, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 6),
                      Text(
                        user!.kakaoAccount!.email!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              const SizedBox(height: 16),
              
              // 추가 사용자 정보 (선택사항)
              if (user?.kakaoAccount?.profile?.thumbnailImageUrl != null) ...[
                const Divider(),
                const SizedBox(height: 12),
                const Text(
                  "계정 정보",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.account_circle, "카카오 ID", "${user?.id}"),
                if (user?.kakaoAccount?.ageRange != null)
                  _buildInfoRow(Icons.cake, "연령대", user!.kakaoAccount!.ageRange!.name),
                if (user?.kakaoAccount?.gender != null)
                  _buildInfoRow(Icons.person_outline, "성별", user!.kakaoAccount!.gender!.name),
              ],
            ],
          ),
        ),
        
        const Spacer(flex: 2),
        
        // 로그아웃 버튼
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: onLogoutPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout, size: 20),
                SizedBox(width: 8),
                Text(
                  "로그아웃",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const Spacer(flex: 1),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            "$label: ",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}