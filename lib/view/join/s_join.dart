import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../common/font/pretendard.dart';

class JoinScreen extends ConsumerStatefulWidget {
  const JoinScreen({super.key});

  @override
  ConsumerState<JoinScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<JoinScreen> {

  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          _buildSunTilte(),
          _buildPhoneNumber(),
        ],
      ),
    );
  }

  Widget _buildSunTilte() {
    return const Text(
      '반가워요! \n본인확인을 해주세요.',
      style: Pretendard.wblack_s24_w700,
    );
  }

  Widget _buildPhoneNumber() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: '휴대폰 번호를 입력해주세요.',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
          },
          child: const Text('인증번호 받기'),
        ),
      ],
    );
  }
}
