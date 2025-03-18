import 'package:flutter/material.dart';

@immutable
class CheckMaintenance {
  final dynamic maintenanceMode;
  final String? message;

  const CheckMaintenance({this.maintenanceMode, this.message});

  factory CheckMaintenance.fromJson(Map<String, dynamic> json) {
    return CheckMaintenance(
      maintenanceMode: json['maintenance_mode'] as dynamic,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'maintenance_mode': maintenanceMode,
        'message': message,
      };
}
