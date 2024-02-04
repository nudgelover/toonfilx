import 'package:flutter/material.dart';
import 'package:toonfilx/services/api_service.dart';
import 'package:toonfilx/widget/webtoon_widget.dart';

import '../models/webtoon_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot))
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
        //사용자가 안보는 데이터는 메모리에서 자동삭제됨.
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data!.length,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        itemBuilder: (BuildContext context, int index) {
          //print(index);
          var webtoon = snapshot.data![index]; //!로 null처리
          return Webtoon(
            title: webtoon.title,
            thumb: webtoon.thumb,
            id: webtoon.id,
          );
        },
        separatorBuilder: (context, snapshot) => const SizedBox(
              width: 40,
            ));
  }
}
