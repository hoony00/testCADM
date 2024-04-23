import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:velocity_x/velocity_x.dart';

class LoadingContainer extends StatelessWidget {
  final String text;
  const LoadingContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitThreeBounce(
              color: Colors.white,
              size: 25.0,
            ), // Circular Indicator 추가
            const SizedBox(height: 16),
            '👨🏻‍️ $text'.text.size(20).white.make(),
          ],
        ),
      ),
    );
  }
}
