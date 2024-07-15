import 'package:db_miner/controller/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  FavoriteController favController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
        title: Text(
          "Favorite Quotes",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff060A13),
      ),
      body: Obx(
        () {
          return favController.favlist.isEmpty
              ? Center(child: Text("No Favorite Quotes"))
              : ListView.builder(
                  itemCount: favController.favlist.length,
                  itemBuilder: (context, index) {
                    var fav = favController.favlist[index];
                    return Stack(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding:
                              EdgeInsets.only(top: 30, left: 15, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[
                                200], // Background color for the container
                            image: DecorationImage(
                              image: fav['image'].toString().isNotEmpty
                                  ? AssetImage(fav['image'].toString())
                                  : AssetImage('assets/bg.jpg'), // default image
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "${fav['favquotes']}",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: IconButton(
                            onPressed: () {
                              favController.removefavQuotes(fav['id'] ?? '');
                            },
                            icon: const Icon(Icons.close),
                            color: Colors.red,
                          ),
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
