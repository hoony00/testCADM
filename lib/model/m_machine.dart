
import 'package:flutter/material.dart';

class MachineModel {
  final String machineImageUrl;
  final String machineName;
  final String machineDescription;
  final String machineType;
  final String youtubeUrl;
  final List<bool> isReservations; // 각 시간별 예약 가능 여부

  MachineModel(
      {required this.machineImageUrl,
      required this.machineName,
      required this.youtubeUrl,
      required this.machineDescription,
      required this.machineType,
      required this.isReservations
      });
}
