import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailMangaPage extends StatefulWidget {
  final num item;
  final String title;
  const DetailMangaPage({Key? key, required this.item, required this.title})
      : super(key: key);

  @override
  _DetailMangaPageState createState() => _DetailMangaPageState();
}

class _DetailMangaPageState extends State<DetailMangaPage> {
  late Future<Manga> manga;

  @override
  void initState() {
    super.initState();
    manga = fetchManga(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
          child: FutureBuilder<Manga>(
        builder: (context, AsyncSnapshot<Manga> snapshot) {
          if (snapshot.hasData) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView(
                  children: [
                    Center(
                      child: Container(
                        width: 222,
                        height: 400,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(snapshot.data!.imageUrl))),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(snapshot.data!.title,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 2),
                    Text(
                      'Score: ${snapshot.data!.score.toString()}',
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Type: ${snapshot.data!.type}',
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${snapshot.data!.synopsis}',
                      textAlign: TextAlign.left,
                    ),
                  ],
                ));
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return const CircularProgressIndicator();
        },
        future: manga,
      )),
    );
  }
}

class Manga {
  final String title;
  final String imageUrl;
  final num score;
  final String type;
  final String synopsis;

  Manga(
      {required this.title,
      required this.imageUrl,
      required this.score,
      required this.type,
      required this.synopsis});

  factory Manga.fromJson(Map<String, dynamic> json) {
    return Manga(
        title: json['title'],
        imageUrl: json['images']['jpg']['large_image_url'],
        score: json['score'],
        type: json['type'],
        synopsis: json['synopsis']);
  }
}

Future<Manga> fetchManga(num id) async {
  final response =
      await http.get(Uri.parse('https://api.jikan.moe/v4/manga/$id'));

  if (response.statusCode == 200) {
    var mangaJson = jsonDecode(response.body)['data'];
    // debugPrint(episodesJson.toString());
    return Manga.fromJson(mangaJson);
  } else {
    throw Exception('Failed to load episodes');
  }
}
