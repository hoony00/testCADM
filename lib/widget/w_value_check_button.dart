import 'package:flutter/material.dart';
/// 값 2개 이상을 받아서 print문으로 찍어주는 버튼 위젯

class ValueCheckButton extends StatelessWidget {
  final dynamic? value1;
  final dynamic? value2;
  final dynamic? value3;
  final dynamic? value4;

  const ValueCheckButton({
    Key? key,
    this.value1,
    this.value2,
    this.value3,
    this.value4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            print('value1: ${value1 ?? 'null'}, value2: ${value2 ?? 'null'}, value3: ${value3 ?? 'null'}, value4: ${value4 ?? 'null'}');
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: const Text(
              '값 확인하기',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

