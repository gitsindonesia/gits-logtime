import 'dart:convert';

import 'package:gits_logtime/helper/print_helper.dart';
import 'package:gits_logtime/models/project.dart';
import 'package:gits_logtime/models/user.dart';
import 'package:gits_logtime/models/workspace.dart';
import 'package:http/http.dart' as http;

abstract class Service {
  static Uri clockifyUrl(String path) =>
      Uri.parse('https://api.clockify.me/api/v1$path');
  static Map<String, String> getHeaders(String apiKey) => {
        'Content-Type': 'application/json',
        'X-Api-Key': apiKey,
      };

  static Future<User> getUser(String apiKey) async {
    PrintHelper.info('Please wait getting user id...');
    final response =
        await http.get(clockifyUrl('/user'), headers: getHeaders(apiKey));
    return User.fromJson(response.body);
  }

  static Future<List<Workspace>> getWorkspaces(String apiKey) async {
    PrintHelper.info('Please wait getting workspaces...');
    final response =
        await http.get(clockifyUrl('/workspaces'), headers: getHeaders(apiKey));
    return (jsonDecode(response.body) as List)
        .map((e) => Workspace.fromMap(e))
        .toList();
  }

  static Future<List<Project>> getProjects(
      String apiKey, String workspaceId) async {
    PrintHelper.info('Please wait getting projects...');
    final response = await http.get(
      clockifyUrl('/workspaces/$workspaceId/projects').replace(
        queryParameters: {'page-size': '5000'},
      ),
      headers: getHeaders(apiKey),
    );
    return (jsonDecode(response.body) as List)
        .map((e) => Project.fromMap(e))
        .toList();
  }

  static Future<bool> addTimeEntry({
    required String apiKey,
    required String workspaceId,
    required String projectId,
    required DateTime startTime,
    required DateTime endTime,
    required String description,
  }) async {
    PrintHelper.info('Please wait add time entry to clockify...');
    final response = await http.post(
      clockifyUrl('/workspaces/$workspaceId/time-entries'),
      headers: getHeaders(apiKey),
      body: jsonEncode({
        "projectId": projectId,
        "description": description,
        "billable": "true",
        "start": startTime.toUtc().toIso8601String(),
        "end": endTime.toUtc().toIso8601String(),
      }),
    );
    return response.statusCode == 201;
  }
}
