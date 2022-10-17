import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:we_move/models/activities.dart';

class ActivitiesService {
  Future<List<dynamic>> getAll() async {
    const url =
        'https://test.backend.wemove.tn/api/v1/client-panel/activities?relations=activityTypes';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final activities = json.map((c) => Activities.fromJson(c)).toList();

      return activities;
    }
    return [];
  }
}
