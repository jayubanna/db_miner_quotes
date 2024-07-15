import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';
import '../controller/random_controller.dart';
import '../helper/db_helper.dart';
import '../model/random_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.quora_outlined,
                  color: Colors.white,
                ),
                child: Text(
                  "local quotes",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.radar,
                  color: Colors.white,
                ),
                child: Text(
                  "random quotes",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          // TabB
          title: Text(
            "Quotes",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff060A13),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                    onPressed: () {
                      Get.toNamed("favorite_page");
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )))
          ],
        ),
        body: TabBarView(
          children: [LocalQuote(), RandomQuotes()],
        ), // ,
      ),
    );
  }
}

class LocalQuote extends StatefulWidget {
  const LocalQuote({super.key});

  @override
  State<LocalQuote> createState() => _LocalQuoteState();
}

class _LocalQuoteState extends State<LocalQuote> {
  final HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    controller.getData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Obx(
          () => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.qList.isNotEmpty
                    ? controller.qList[0].categories?.length
                    : 0,
                itemBuilder: (context, index) {
                  var ql = controller.qList[0].categories;
                  return Obx(
                    () => GestureDetector(
                      onTap: () {
                        controller.cindex.value = index;
                      },
                      child: AnimatedContainer(
                        width: 120,
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: controller.cindex.value == index
                              ? BorderRadius.circular(15)
                              : BorderRadius.circular(10),
                          color: controller.cindex.value == index
                              ? Colors.black
                              : Colors.black38,
                        ),
                        duration: Duration(milliseconds: 500),
                        child: Center(
                          child: Text(
                            ql?[index] ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ), // Text color
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: Builder(
            builder: (context) {
              return Obx(
                () => IndexedStack(
                  index: controller.cindex.value,
                  children: [
                    ListView.builder(
                      itemCount: controller.qList.isNotEmpty
                          ? controller.qList[0].happiness?.length ?? 0
                          : 0,
                      itemBuilder: (context, index) {
                        var qqList = controller.qList[0].happiness;

                        return Stack(
                          children: [
                            Container(
                              height: 200,
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              padding:
                                  EdgeInsets.only(top: 30, left: 15, right: 10),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        controller.qList[0].happinessImage ??
                                            ''),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  qqList![index],
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                onPressed: () async {
                                  var quote =
                                      controller.qList[0].happiness![index];
                                  DbHelper helper = DbHelper();
                                  bool quoteExists =
                                      await helper.checkquote(quote);

                                  if (quoteExists) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Quote is already in favorites'),
                                      ),
                                    );
                                  } else {
                                    await helper.insertFavorite(
                                        quote, 'happiness',
                                        image: controller
                                                .qList[0].happinessImage ??
                                            '');

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Quote added to favorites'),
                                      ),
                                    );
                                  }
                                },
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: controller.qList.isNotEmpty
                          ? controller.qList[0].friendship?.length ?? 0
                          : 0,
                      itemBuilder: (context, index) {
                        var qqList = controller.qList[0].friendship;

                        return Stack(
                          children: [
                            Container(
                              height: 200,
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              padding:
                                  EdgeInsets.only(top: 30, left: 15, right: 10),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        controller.qList[0].friendshipImage ??
                                            ''),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  qqList![index],
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.black),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                onPressed: () async {
                                  var quote =
                                      controller.qList[0].friendship![index];
                                  DbHelper helper = DbHelper();
                                  bool quoteExists =
                                      await helper.checkquote(quote);

                                  if (quoteExists) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Quote is already in favorites'),
                                      ),
                                    );
                                  } else {
                                    await helper.insertFavorite(
                                        quote, 'friendship',
                                        image: controller
                                                .qList[0].friendshipImage ??
                                            '');

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Quote added to favorites'),
                                      ),
                                    );
                                  }
                                },
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: controller.qList.isNotEmpty
                          ? controller.qList[0].motivational?.length ?? 0
                          : 0,
                      itemBuilder: (context, index) {
                        var qqList = controller.qList[0].motivational;

                        return Stack(
                          children: [
                            Container(
                              height: 200,
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              padding:
                                  EdgeInsets.only(top: 30, left: 15, right: 10),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        controller.qList[0].motivationalImage ??
                                            ''),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  qqList![index],
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                onPressed: () async {
                                  var quote =
                                      controller.qList[0].motivational![index];
                                  DbHelper helper = DbHelper();
                                  bool quoteExists =
                                      await helper.checkquote(quote);

                                  if (quoteExists) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Quote is already in favorites'),
                                      ),
                                    );
                                  } else {
                                    await helper.insertFavorite(
                                        quote, 'motivational',
                                        image: controller
                                                .qList[0].motivationalImage ??
                                            '');

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Quote added to favorites'),
                                      ),
                                    );
                                  }
                                },
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: controller.qList.isNotEmpty
                          ? controller.qList[0].positive?.length ?? 0
                          : 0,
                      itemBuilder: (context, index) {
                        var qqList = controller.qList[0].positive;

                        return Stack(
                          children: [
                            Container(
                              height: 200,
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              padding:
                                  EdgeInsets.only(top: 30, left: 15, right: 10),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        controller.qList[0].positiveImage ??
                                            ''),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  qqList![index],
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.black),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                onPressed: () async {
                                  var quote =
                                      controller.qList[0].positive![index];
                                  DbHelper helper = DbHelper();
                                  bool quoteExists =
                                      await helper.checkquote(quote);

                                  if (quoteExists) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Quote is already in favorites'),
                                      ),
                                    );
                                  } else {
                                    await helper.insertFavorite(
                                        quote, 'positive',
                                        image:
                                            controller.qList[0].positiveImage ??
                                                '');

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Quote added to favorites'),
                                      ),
                                    );
                                  }
                                },
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: controller.qList.isNotEmpty
                          ? controller.qList[0].success?.length ?? 0
                          : 0,
                      itemBuilder: (context, index) {
                        var qqList = controller.qList[0].success;

                        return Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              padding:
                                  EdgeInsets.only(top: 30, left: 15, right: 10),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        controller.qList[0].successImage ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  qqList![index],
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                onPressed: () async {
                                  var quote =
                                      controller.qList[0].success![index];
                                  DbHelper helper = DbHelper();
                                  bool quoteExists =
                                      await helper.checkquote(quote);

                                  if (quoteExists) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Quote is already in favorites'),
                                      ),
                                    );
                                  } else {
                                    await helper.insertFavorite(
                                        quote, 'success',
                                        image:
                                            controller.qList[0].successImage ??
                                                '');

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Quote added to favorites'),
                                      ),
                                    );
                                  }
                                },
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: controller.qList.isNotEmpty
                          ? controller.qList[0].smile?.length ?? 0
                          : 0,
                      itemBuilder: (context, index) {
                        var qqList = controller.qList[0].smile;

                        return Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              padding:
                                  EdgeInsets.only(top: 30, left: 15, right: 10),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        controller.qList[0].smileImage ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  qqList![index],
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                onPressed: () async {
                                  var quote = controller.qList[0].smile![index];
                                  DbHelper helper = DbHelper();
                                  bool quoteExists =
                                      await helper.checkquote(quote);

                                  if (quoteExists) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Quote is already in favorites'),
                                      ),
                                    );
                                  } else {
                                    await helper.insertFavorite(quote, 'smile',
                                        image: controller.qList[0].smileImage ??
                                            '');

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Quote added to favorites'),
                                      ),
                                    );
                                  }
                                },
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: controller.qList.isNotEmpty
                          ? controller.qList[0].leadership?.length ?? 0
                          : 0,
                      itemBuilder: (context, index) {
                        var qqList = controller.qList[0].leadership;

                        return Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              padding:
                                  EdgeInsets.only(top: 30, left: 15, right: 10),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        controller.qList[0].leadershipImage ??
                                            ''),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  qqList![index],
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.black),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                onPressed: () async {
                                  var quote =
                                      controller.qList[0].leadership![index];
                                  DbHelper helper = DbHelper();
                                  bool quoteExists =
                                      await helper.checkquote(quote);

                                  if (quoteExists) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Quote is already in favorites'),
                                      ),
                                    );
                                  } else {
                                    await helper.insertFavorite(
                                        quote, 'leadership',
                                        image: controller
                                                .qList[0].leadershipImage ??
                                            '');

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Quote added to favorites'),
                                      ),
                                    );
                                  }
                                },
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class RandomQuotes extends StatefulWidget {
  const RandomQuotes({Key? key}) : super(key: key);

  @override
  State<RandomQuotes> createState() => _RandomQuotesState();
}
class _RandomQuotesState extends State<RandomQuotes> {
  RandomController rc = Get.put(RandomController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () {
          if (rc.random.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            Rx<RandomQuote> ran = rc.random[rc.cIndex].obs;
            return Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/bg.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black54,
                        ),
                        child: Center(
                          child: Obx(
                                () => Text(
                              ran.value.q ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: IconButton(
                          onPressed: () async{
                            var sample = rc.random[rc.cIndex];
                            String? quoteContent = sample.q;
                            DbHelper helper = DbHelper();
                            bool quoteExists = await helper.checkquote(quoteContent!);

                            if (quoteExists) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Quote is already in favorites'),
                                ),
                              );
                            } else {
                              helper.insertFavorite(quoteContent, "${sample.tags}");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Quote added to favorites'),
                                ),
                              );
                            }

                          },
                          icon: Icon(
                            Icons.favorite_border,
                            size: 30,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blueGrey)),
                    onPressed: () {
                      rc.getApi();
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

