import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toonfilx/services/api_service.dart';

import '../models/webtoon_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WebtoonModel> webtoons = [];
  bool isLoading = true;

  void waitForWebtoon() async {
    webtoons = await ApiService.getTodaysToons();
    isLoading = false;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    waitForWebtoon();
  }

  @override
  Widget build(BuildContext context) {
    print(webtoons);   
    print(isLoading);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Center(
          child: Text(
            "오늘의 웹툰",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
