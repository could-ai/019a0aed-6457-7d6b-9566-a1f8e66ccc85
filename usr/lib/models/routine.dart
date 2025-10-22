import 'package:flutter/material.dart';

class Routine {
  final String id;
  final String title;
  final String startTime;
  final String endTime;
  final List<int> daysOfWeek; // 1 = Monday, 7 = Sunday
  final IconData icon;
  bool isActive;

  Routine({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.daysOfWeek,
    required this.icon,
    required this.isActive,
  });

  Routine copyWith({
    String? id,
    String? title,
    String? startTime,
    String? endTime,
    List<int>? daysOfWeek,
    IconData? icon,
    bool? isActive,
  }) {
    return Routine(
      id: id ?? this.id,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      icon: icon ?? this.icon,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'startTime': startTime,
      'endTime': endTime,
      'daysOfWeek': daysOfWeek,
      'icon': icon.codePoint, // Store icon as code point
      'isActive': isActive,
    };
  }

  factory Routine.fromJson(Map<String, dynamic> json) {
    return Routine(
      id: json['id'],
      title: json['title'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      daysOfWeek: List<int>.from(json['daysOfWeek']),
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      isActive: json['isActive'],
    );
  }
}
