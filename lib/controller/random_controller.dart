import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/random_model.dart';

class RandomController extends GetxController {
  RxList<RandomQuote> random = <RandomQuote>[].obs;
  int cIndex = 0;

  @override
  void onInit() {
    super.onInit();
    getApi();
  }

  void getApi() async {
    try {
      var response = await http.get(Uri.parse("https://zenquotes.io/api/quotes"));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List;
        List<RandomQuote> quotes = jsonData.map((quoteJson) => RandomQuote.fromJson(quoteJson)).toList();
        random.value = quotes.obs;
        if (quotes.isNotEmpty) {
          update();
          print("LENGTH==> ${random.length}");
        }
      } else {
        print("Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}