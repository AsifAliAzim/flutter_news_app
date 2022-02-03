import 'package:flutter/material.dart';
import 'package:rest_apis/models/newsinfo.dart';

import '../helper/api_manager.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Welcome>? _newsModel;

  @override
  void initState() {
    super.initState();
    _newsModel = Api_Manager().getNews();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("News App"),
      centerTitle: true,
    );
    return Scaffold(
      appBar: appBar,
      body: Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.99,
        child: FutureBuilder<Welcome>(
            future: _newsModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.articles.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data?.articles[index];
                    return Container(
                      height: MediaQuery.of(context).size.height *
                          0.2, //this means we want to occupy 60 % height of the availabe screen including appbar
                      margin: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: AspectRatio(
                              aspectRatio: 1.1,
                              child: Image.network(
                                article!.urlToImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 15.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    article.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
