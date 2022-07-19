import 'package:movie_app_sqlite/model/categories.dart';
import 'package:movie_app_sqlite/model/director.dart';

class Movies {
  int movieId;
  String movieName;
  int movieYear;
  String movieImage;
  Categories categori;
  Director director;
  Movies(this.movieId, this.movieName, this.movieYear, this.movieImage,
      this.categori, this.director);
}
