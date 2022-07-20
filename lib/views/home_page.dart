import 'package:flutter/material.dart';
import 'package:movie_app_sqlite/model/categories.dart';
import 'package:movie_app_sqlite/views/movie_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Categories>> showAllCategories() async {
    List<Categories> categoryList = [];
    var k1 = Categories(1, "Komedi");
    var k2 = Categories(2, "Bilim Kurgu");
    categoryList.add(k1);
    categoryList.add(k2);
    return categoryList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnaSayfa'),
      ),
      body: FutureBuilder<List<Categories>>(
        future: showAllCategories(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Categories> categoryList = snapshot.data;
            return ListView.separated(
              itemCount: categoryList.length,
              itemBuilder: (BuildContext context, int index) {
                var category = categoryList[index];
                return SizedBox(
                  height: 60,
                  child: Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(5),
                    color: Colors.cyan.shade200,
                    child: ListTile(
                      title: Text(category.categoryName),
                      leading: const Icon(Icons.movie),
                      trailing: const Icon(Icons.arrow_right_alt_rounded),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MoviePage(category: category),
                            ));
                      },
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: Colors.grey,
                  endIndent: 60,
                  indent: 60,
                  height: 1,
                  thickness: 1,
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
