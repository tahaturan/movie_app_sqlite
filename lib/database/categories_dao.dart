import 'package:movie_app_sqlite/database/database_helper.dart';
import 'package:movie_app_sqlite/model/categories.dart';

class CategoriesDao {
  static Future<List<Categories>> allCategories() async {
    var db = await DataBaseHelper.dataBaseConnect();
    String sql = "SELECT * FROM kategoriler";
    List<Map<String, dynamic>> maps = await db.rawQuery(sql);

    return List.generate(maps.length, (index) {
      var line = maps[index];
      return Categories(line["kategori_id"], line["kategori_ad"]);
    });
  }
}
