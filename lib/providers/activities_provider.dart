import 'package:flutter/material.dart';
import '../services/activities_service.dart';

class ActivitiesProvider extends ChangeNotifier {
  final _service = ActivitiesService();
  bool isLoading = false;
  List<dynamic> __activitiesList = [];
  List<dynamic> get activities => __activitiesList;
  List<dynamic> __activitiesTypesList = [];
  List<dynamic> get activitiesTypes => __activitiesTypesList;
  List<String> typeActivities = [];

  Future<void> getAllActivities() async {
    isLoading = true;
    notifyListeners();
    final response = await _service.getAll();

    __activitiesList = response;
    __activitiesTypesList = getActivitiesType();

    isLoading = false;
    notifyListeners();
  }

  List<String> getActivitiesType() {
    var seen = Set<String>();
    if (__activitiesList.isNotEmpty) {
      __activitiesList.forEach((element) {
        element.activityTypes!.forEach((element) {
          typeActivities.add(element.label);
        });
      });
    }

    return typeActivities.where((type) => seen.add(type)).toList();
  }
}
