import 'dart:convert';
import 'package:db_miner/model/home_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../helper/db_helper.dart';

class HomeController extends GetxController {
  RxInt cindex = 0.obs;
  RxList<Quotes> qList = <Quotes>[].obs;
  Quotes? quotes;
  final DbHelper _dbHelper = DbHelper();

  Future getData() async {
    var filedata = await rootBundle.loadString("jsons/quotes.json");
    jsonDecode(filedata);
    qList.value = quotesFromJson(filedata);
  }

  Future<void> insertFavorite(String quote, String category,
      {String? image}) async {
    await _dbHelper.insertFavorite(quote, category, image: image);
  }

  Future<bool> checkquote(String quote) async {
    return await _dbHelper.checkquote(quote);
  }

  @override
  void onInit() {
    super.onInit();
    getData();
    _dbHelper.initDb();
  }
}
