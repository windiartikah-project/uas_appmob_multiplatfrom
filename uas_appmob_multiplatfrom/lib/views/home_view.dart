import 'package:flutter/material.dart';
import 'package:uas/models/news.dart';
import 'package:uas/services/api_service.dart';
import 'package:uas/views/read_news_view.dart';
import 'package:uas/widgets/primary_card.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<List<News>> getNews;

  @override
  void initState() {
    super.initState();
    getNews = ApiService().getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          FutureBuilder(
            future: getNews,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<News> news = snapshot.data;

                return ListView.builder(
                  itemCount: news.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    var _home = news[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReadNewsView(news: _home),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 300.0,
                        margin: EdgeInsets.symmetric(
                          horizontal: 18.0,
                          vertical: 12.0,
                        ),
                        child: PrimaryCard(
                          news: _home,
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text(("${snapshot.error}"));
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }
}
