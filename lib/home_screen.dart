import 'package:flutter/material.dart';
import 'package:flutter_faking_server_data/news_article_model.dart';
import 'package:flutter_faking_server_data/news_repository.dart';
import 'package:flutter_faking_server_data/ui_keys.dart';
import 'package:http/io_client.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<NewsArticleModel>> _topHeadlinesFuture;

  @override
  void initState() {
    super.initState();

    _topHeadlinesFuture = NewsRepository(
      httpClient: IOClient(),
    ).getTopHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(key: Key(UIKeys.appBar), title: Text('Faking Server Data')),
      body: Center(
        child: FutureBuilder<List<NewsArticleModel>>(
          future: _topHeadlinesFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                key: Key(UIKeys.homeHeadlinesList),
                children: snapshot.data.map((x) => _NewsArticleItem(model: x)).toList(),
              );
            } else if (snapshot.hasError) {
              return Text("An error has occurred :(");
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class _NewsArticleItem extends StatelessWidget {
  const _NewsArticleItem({Key key, @required this.model}) : super(key: key);

  final NewsArticleModel model;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: model.imageUrl != null
          ? Image.network(
              model.imageUrl,
              width: 100,
              fit: BoxFit.fill,
            )
          : Container(
              color: Colors.greenAccent,
              width: 100,
            ),
      title: Text(
        model.title,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
