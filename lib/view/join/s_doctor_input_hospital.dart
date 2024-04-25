import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DoctorInputHospitalScreen extends ConsumerStatefulWidget {
  const DoctorInputHospitalScreen({super.key});


  @override
  ConsumerState<DoctorInputHospitalScreen> createState() => _DoctorInputHospitalScreenState();
}

class _DoctorInputHospitalScreenState extends ConsumerState<DoctorInputHospitalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DoctorSelectHospitalScreen'),
      ),
      body: Center(
        child: Text('DoctorSelectHospitalScreen'),
      ),
    );
  }
}
