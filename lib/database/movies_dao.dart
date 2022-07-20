import 'package:movie_app_sqlite/database/database_helper.dart';
import 'package:movie_app_sqlite/model/categories.dart';
import 'package:movie_app_sqlite/model/director.dart';
import 'package:movie_app_sqlite/model/movies.dart';

class MovieDao {
  static Future<List<Movies>> allMoviesByCategoryId(int categoryId) async {
    var db = await DataBaseHelper.dataBaseConnect();
    String sql = """
SELECT * FROM filmler,kategoriler,yonetmenler WHERE filmler.kategori_id=kategoriler.kategori_id and filmler.yonetmen_id=yonetmenler.yonetmen_id 
and filmler.kategori_id=$categoryId
  """;
    List<Map<String, dynamic>> maps = await db.rawQuery(sql);
    return List.generate(maps.length, (index) {
      var line = maps[index];
      var k = Categories(line["kategori_id"], line["kategori_ad"]);
      var y = Director(line["yonetmen_id"], line["yonetmen_ad"]);
      var f = Movies(line["film_id"], line["film_ad"], line["film_yil"],
          line["film_resim"], k, y);
      return f;
    });
  }
}
