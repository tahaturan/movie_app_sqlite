import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_sqlite/model/categories.dart';
import 'package:movie_app_sqlite/model/director.dart';
import 'package:movie_app_sqlite/model/movies.dart';

class MoviePage extends StatefulWidget {
  Categories category;
  MoviePage({required this.category, Key? key}) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  Future<List<Movies>> showAllMovies(int categoryId) async {
    List<Movies> movieList = [];

    var k1 = Categories(1, "Komedi");
    var y1 = Director(1, "Quentin Tarantino");

    var f1 = Movies(1, "Anadoluda", 2008, "anadoluda.png", k1, y1);
    var f2 = Movies(2, "Django", 2009, "django.png", k1, y1);
    var f3 = Movies(3, "Inception", 2010, "inception.png", k1, y1);
    movieList.add(f1);
    movieList.add(f2);
    movieList.add(f3);
    return movieList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filmler: ${widget.category.categoryName}'),
      ),
      body: FutureBuilder<List<Movies>>(
        future: showAllMovies(widget.category.categoryId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Movies> movieList = snapshot.data;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3.5,
              ),
              itemCount: movieList.length,
              itemBuilder: (BuildContext context, int index) {
                var movie = movieList[index];
                return GestureDetector(
                  onTap: () {
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.SCALE,
                      dialogType: DialogType.INFO_REVERSED,
                      body: Center(
                          child: Text(
                              "Yonetmen: ${movie.director.directorName} Yapim Yili: ${movie.movieYear}")),
                      btnOkOnPress: () {},
                    ).show();
                  },
                  child: Card(
                      elevation: 5,
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                                "assets/images/${movie.movieImage}"),
                          ),
                          Text(
                            movie.movieName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
