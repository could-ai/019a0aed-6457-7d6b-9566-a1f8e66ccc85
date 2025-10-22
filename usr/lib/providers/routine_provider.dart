import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/routine.dart';

class RoutineProvider with ChangeNotifier {
  List<Routine> _routines = [];

  List<Routine> get routines => _routines;

  RoutineProvider() {
    _loadRoutines();
  }

  void addRoutine(Routine routine) {
    _routines.add(routine);
    _saveRoutines();
    notifyListeners();
  }

  void removeRoutine(String routineId) {
    _routines.removeWhere((routine) => routine.id == routineId);
    _saveRoutines();
    notifyListeners();
  }

  void toggleRoutineActive(String routineId) {
    final routineIndex = _routines.indexWhere((routine) => routine.id == routineId);
    if (routineIndex != -1) {
      _routines[routineIndex] = _routines[routineIndex].copyWith(
        isActive: !_routines[routineIndex].isActive,
      );
      _saveRoutines();
      notifyListeners();
    }
  }

  void updateRoutine(Routine updatedRoutine) {
    final routineIndex = _routines.indexWhere((routine) => routine.id == updatedRoutine.id);
    if (routineIndex != -1) {
      _routines[routineIndex] = updatedRoutine;
      _saveRoutines();
      notifyListeners();
    }
  }

  Future<void> _loadRoutines() async {
    final prefs = await SharedPreferences.getInstance();
    final routinesJson = prefs.getStringList('routines') ?? [];
    _routines = routinesJson.map((json) => Routine.fromJson(jsonDecode(json))).toList();
    notifyListeners();
  }

  Future<void> _saveRoutines() async {
    final prefs = await SharedPreferences.getInstance();
    final routinesJson = _routines.map((routine) => jsonEncode(routine.toJson())).toList();
    await prefs.setStringList('routines', routinesJson);
  }
}