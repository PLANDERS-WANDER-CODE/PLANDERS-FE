import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../utils/theme/colors.dart';
import 'forgot_password_screen.dart';
import 'signup_screen.dart';

// 로그인 화면의 StatefulWidget 클래스
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// 로그인 화면의 상태 관리 클래스
class _LoginScreenState extends State<LoginScreen> {
  // 아이디와 비밀번호 입력을 위한 컨트롤러
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 로그인 처리를 위한 비동기 함수
  Future<void> _login() async {
    // 아이디와 비밀번호 입력 여부 검증
    if (_idController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('아이디와 비밀번호를 모두 입력해주세요.')),
      );
      return;
    }

    // 서버에 전송할 로그인 데이터 구조 정의
    final Map<String, dynamic> loginData = {
      'key': {
        'accountId': _idController.text
      },
      'password': _passwordController.text,
    };

    try {
      // HTTP POST 요청을 통한 로그인 시도
      final response = await http.post(
        Uri.parse('https://your-backend-url/api/auth'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: json.encode(loginData),
      );

      if (response.statusCode == 200) {
        // 로그인 성공 시 처리
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('로그인 성공')),
          );
          // TODO: 메인 화면으로 이동하는 네비게이션 추가
        }
      } else {
        // 로그인 실패 시 처리
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('로그인 실패: ${response.body}')),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱바 설정
      appBar: AppBar(
        title: const Text(
          'Planders',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      // 스크롤 가능한 본문 영역
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // 아이디 입력 섹션
              const Text(
                'ID',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _idController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // 비밀번호 입력 섹션
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: true, // 비밀번호 텍스트 숨김 처리
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              // 로그인 버튼
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    '로그인',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // 비밀번호 찾기 및 회원가입 버튼 행
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 비밀번호 찾기 버튼
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      '비밀번호를 잊으셨습니까?',
                      style: TextStyle(
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  // 회원가입 버튼
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.buttonBackground,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    child: const Text(
                      '회원가입',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // 구글 로그인 버튼
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: 구글 로그인 기능 구현
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.googleButtonBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'Google 로그인',
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
      ),
    );
  }

  // 컨트롤러 해제
  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}