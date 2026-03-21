import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const ScoreSightApp());

class ScoreSightApp extends StatelessWidget {
  const ScoreSightApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const PredictionScreen(),
    );
  }
}

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});
  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final TextEditingController _studyController = TextEditingController();
  final TextEditingController _selfstudyController = TextEditingController();
  final TextEditingController _onlineclassesController =
      TextEditingController();
  final TextEditingController _mentalhealthController = TextEditingController();
  String _result = "enter data and press predict";
  Future<void> _getprediction() async {
    final url = Uri.parse('http://127.0.0.1:5000/predict');
    try {
      final response = await http.post(
        url,
        headers: {"Context-Type":"application/json"},
        body: jsonEncode({
          "study_hours": int.parse(_studyController.text),
          "self_study": int.parse(_selfstudyController.text),
          "online_classes_hours": int.parse(_onlineclassesController.text),
          "meantal_health_score": int.parse(_mentalhealthController.text),
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _result = "alert:${data['alerts']}";
        });
      }
    } catch (e) {
      setState(() {
        _result = "error:API IS NOT RUNNING";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("scoresight predictor")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _studyController,
              decoration: const InputDecoration(labelText: "study hours"),
            ),
            TextField(
              controller: _selfstudyController,
              decoration: const InputDecoration(labelText: "selfstudy hours"),
            ),
            TextField(
              controller: _onlineclassesController,
              decoration: const InputDecoration(
                labelText: "online class hours",
              ),
            ),
            TextField(
              controller: _mentalhealthController,
              decoration: const InputDecoration(
                labelText: "mental health score(1-10)",
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _getprediction,
              child: const Text("predict"),
            ),
            const SizedBox(height: 30),
            Text(
              _result,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
