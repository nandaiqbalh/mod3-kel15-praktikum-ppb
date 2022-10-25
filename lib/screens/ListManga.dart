import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:mod3_kel15/screens/DetailManga.dart';

class ListMangaPage extends StatefulWidget {
  const ListMangaPage({Key? key}) : super(key: key);

  @override
  State<ListMangaPage> createState() => _ListMangaPageState();
}

class _ListMangaPageState extends State<ListMangaPage> {
  late Future<List<Show>> shows;

  @override
  void initState() {
    super.initState();
    shows = fetchShows();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<List<Show>> snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Center(child: Text("TOP MANGA", style: GoogleFonts.poppins())),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 200.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailMangaPage(
                                  item: snapshot.data![index].malId,
                                  title: snapshot.data![index].title),
                            ),
                          );
                        },
                        child: Container(
                          width: 160.0,
                          margin: EdgeInsets.only(right: 16.0),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(snapshot
                                      .data![index].images.jpg.image_url))),
                          child: Center(
                              child: Text(
                            snapshot.data![index].title,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              backgroundColor:
                                  Color.fromARGB(255, 247, 229, 198),
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.center,
                          )),
                        ),
                      );
                    }),
              ),
              Expanded(
                  child: Container(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              snapshot.data![index].images.jpg.image_url),
                        ),
                        title: Text(snapshot.data![index].title),
                        subtitle: Text('Score: ${snapshot.data![index].score}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailMangaPage(
                                  item: snapshot.data![index].malId,
                                  title: snapshot.data![index].title),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ))
            ],
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }
        return Center(child: CircularProgressIndicator());
      },
      future: shows,
    );
  }
}

class Show {
  final num malId;
  final String title;
  Images images;
  final num score;

  Show({
    required this.malId,
    required this.title,
    required this.images,
    required this.score,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      malId: json['mal_id'],
      title: json['title'],
      images: Images.fromJson(json['images']),
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() => {
        'mal_id': malId,
        'title': title,
        'images': images,
        'score': score,
      };
}

class Images {
  final Jpg jpg;

  Images({required this.jpg});
  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      jpg: Jpg.fromJson(json['jpg']),
    );
  }

  Map<String, dynamic> toJson() => {
        'jpg': jpg.toJson(),
      };
}

class Jpg {
  String image_url;
  String small_image_url;
  String large_image_url;

  Jpg({
    required this.image_url,
    required this.small_image_url,
    required this.large_image_url,
  });

  factory Jpg.fromJson(Map<String, dynamic> json) {
    return Jpg(
      image_url: json['image_url'],
      small_image_url: json['small_image_url'],
      large_image_url: json['large_image_url'],
    );
  }
  //to json
  Map<String, dynamic> toJson() => {
        'image_url': image_url,
        'small_image_url': small_image_url,
        'large_image_url': large_image_url,
      };
}

Future<List<Show>> fetchShows() async {
  final response =
      await http.get(Uri.parse('https://api.jikan.moe/v4/top/manga'));

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body)['data'] as List;
    return jsonResponse.map((show) => Show.fromJson(show)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}
