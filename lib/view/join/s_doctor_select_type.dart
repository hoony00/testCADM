import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoctorSelectTypeScreen extends ConsumerStatefulWidget {
  const DoctorSelectTypeScreen({super.key});


  @override
  ConsumerState<DoctorSelectTypeScreen> createState() => _DoctorSelectTypeScreenState();
}

class _DoctorSelectTypeScreenState extends ConsumerState<DoctorSelectTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DoctorSelectType'),
      ),
      body: Center(
        child: Text('DoctorSelectType'),
      ),
    );
  }
}
