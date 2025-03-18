import 'package:flutter/material.dart';

@immutable
class CheckUpdate {
  final int? forceUpdate;
  final String? version;
  final String? url;

  const CheckUpdate({
    this.forceUpdate,
    this.version,
    this.url,
  });

  factory CheckUpdate.fromMap(Map<String, dynamic> data) => CheckUpdate(
        forceUpdate: data['force_update'] as int?,
        version: data['version'] as String?,
        url: data['update_url'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'force_update': forceUpdate,
        'version': version,
        'update_url': url,
      };
}
