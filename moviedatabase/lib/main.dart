import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Database',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Movie Database'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String mediaType = 'movie';
  String userInputName = '';
  List<dynamic> mediaList = [];
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: mediaType,
              items: [
                DropdownMenuItem(
                  value: 'movie',
                  child: Text('Movie'),
                ),
                DropdownMenuItem(
                  value: 'tv',
                  child: Text('TV Show'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  mediaType = value!;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'What title would you like to search for?',
              ),
              onChanged: (value) {
                userInputName = value;
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                mediaList = await fetchMedia(
                    "https://api.themoviedb.org/3/search/$mediaType?query=${Uri.encodeQueryComponent(userInputName)}&api_key=YOUR_API_KEY");

                setState(() {});
              } catch (e) {
                print("Error fetching data: $e");
              }
            },
            child: Text('Search'),
          ),
          if (mediaList.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: mediaList.length,
                itemBuilder: (context, index) {
                  if (mediaType == 'movie') {
                    final movie = mediaList[index] as Movie;
                    return ListTile(
                      title: Text(movie.title),
                      subtitle: Text(movie.releaseDate),
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    );
                  } else {
                    final tvShow = mediaList[index] as TV;
                    return ListTile(
                      title: Text(tvShow.name),
                      subtitle: Text(tvShow.firstAirDate),
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    );
                  }
                },
              ),
            ),
          if (selectedIndex != -1)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (mediaType == 'movie') ...[
                      ListTile(
                        title: Text('Title:'),
                        subtitle: Text(mediaList[selectedIndex].title),
                      ),
                      ListTile(
                        title: Text('Release Date:'),
                        subtitle: Text(mediaList[selectedIndex].releaseDate),
                      ),
                      ListTile(
                        title: Text('Tagline:'),
                        subtitle: Text(mediaList[selectedIndex].tagline),
                      ),
                    ] else ...[
                      ListTile(
                        title: Text('Name:'),
                        subtitle: Text(mediaList[selectedIndex].name),
                      ),
                      ListTile(
                        title: Text('First Air Date:'),
                        subtitle: Text(mediaList[selectedIndex].firstAirDate),
                      ),
                      ListTile(
                        title: Text('Overview:'),
                        subtitle: Text(mediaList[selectedIndex].overview),
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<List<dynamic>> fetchMedia(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        List<dynamic> results = jsonResponse['results'];
        List<dynamic> mediaList = [];

        for (var data in results) {
          if (data.containsKey('title')) {
            mediaList.add(Movie.fromJson(data));
          } else if (data.containsKey('original_name')) {
            mediaList.add(TV.fromJson(data));
          }
        }

        return mediaList;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }
}

class Movie {
  final String title;
  final String releaseDate;
  final String tagline;

  Movie({
    required this.title,
    required this.releaseDate,
    required this.tagline,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      releaseDate: json['release_date'] ?? "Unknown",
      tagline: json['tagline'] ?? "No tagline available",
    );
  }
}

class TV {
  final String name;
  final String firstAirDate;
  final String overview;

  TV({
    required this.name,
    required this.firstAirDate,
    required this.overview,
  });

  factory TV.fromJson(Map<String, dynamic> json) {
    return TV(
      name: json['original_name'] ?? 'Unknown',
      firstAirDate: json['first_air_date'] ?? 'Unknown',
      overview: json['overview'] ?? 'No description available',
    );
  }
}
