import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/theme/colors.dart';

// 비밀번호 찾기 화면의 StatefulWidget 클래스
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

// 비밀번호 찾기 화면의 상태 관리 클래스
class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // 이메일 입력을 위한 컨트롤러
  final TextEditingController _emailController = TextEditingController();

  // 비밀번호 재설정 링크 전송 중 로딩 상태를 관리하는 변수
  bool _isLoading = false;

  // 비밀번호 재설정 링크 전송 함수
  Future<void> _sendResetLink() async {
    // 이메일 입력 여부 검증
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이메일을 입력해주세요.')),
      );
      return;
    }

    // 로딩 상태 시작
    setState(() {
      _isLoading = true;
    });

    try {
      // 서버에 비밀번호 재설정 요청 전송
      final response = await http.post(
        Uri.parse('https://your-backend-url/api/reset-password'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'email': _emailController.text,
        }),
      );

      if (mounted) {
        // 요청 성공 시 처리
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('비밀번호 재설정 링크가 이메일로 전송되었습니다.')),
          );
          Navigator.pop(context); // 이전 화면으로 돌아가기
        } else {
          // 요청 실패 시 처리
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('비밀번호 재설정 요청에 실패했습니다.')),
          );
        }
      }
    } catch (e) {
      // 네트워크 오류 등 예외 상황 처리
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류가 발생했습니다: $e')),
        );
      }
    } finally {
      // 로딩 상태 종료
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱바 설정
      appBar: AppBar(
        title: const Text('비밀번호 찾기'),
        backgroundColor: AppColors.primary,
      ),
      // 화면 본문
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 안내 텍스트
            const Text(
              '가입했던 이메일을 입력해주세요.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            // 이메일 입력 필드
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: '이메일',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress, // 이메일 전용 키보드 설정
            ),
            const SizedBox(height: 24),
            // 비밀번호 재설정 링크 전송 버튼
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                // 로딩 중일 때는 버튼 비활성화
                onPressed: _isLoading ? null : _sendResetLink,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                // 로딩 중일 때는 로딩 인디케이터 표시, 아닐 때는 텍스트 표시
                child: _isLoading
                    ? const CircularProgressIndicator(color: AppColors.white)
                    : const Text(
                  '비밀번호 재설정 링크 보내기',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}