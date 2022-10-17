import 'package:flutter/material.dart';
import '../models/activities_card.dart';
import '../services/activities_service.dart';

class ActivitiesProvider extends ChangeNotifier {
  final _service = ActivitiesService();
  bool isLoading = false;
  List<dynamic> _activitiesList = [];
  List<dynamic> get activities => _activitiesList;
  List<dynamic> _typesList = [];
  List<dynamic> get activitiesTypes => _typesList;
  List<String> typeActivities = [];

  List<ActivitiesCard> _activitiesByTypeList = [];
  List<ActivitiesCard> get activitiesByType => _activitiesByTypeList;

  Future<void> getAllActivities() async {
    isLoading = true;
    notifyListeners();
    final response = await _service.getAll();

    _activitiesList = response;
    _typesList = getTypes();

    isLoading = false;
    notifyListeners();
  }

  List<String> getTypes() {
    var seen = Set<String>();
    if (_activitiesList.isNotEmpty) {
      _activitiesList.forEach((element) {
        element.activityTypes!.forEach((element) {
          typeActivities.add(element.label);
        });
      });
    }

    return typeActivities.where((type) => seen.add(type)).toList();
  }

  List<ActivitiesCard> getActivitiesByType(String type) {
    _activitiesList.forEach((element1) {
      element1.activityTypes!.forEach((element) {
        if (element.label!.contains(type)) {
          _activitiesByTypeList.add(ActivitiesCard(
              image: element1.image1,
              name: element1.name,
              description: element1.description));
        }
      });
    });
    notifyListeners();
    return _activitiesByTypeList;
  }
}
