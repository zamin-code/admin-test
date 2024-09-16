import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_resto/common.dart';

import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
                items: homeController.imgAds.map(
                  (url) {
                    return Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        // child: CachedNetworkImage(
                        //   imageUrl: url,
                        //   fit: BoxFit.fill,
                        //   width: 1000.0,
                        //   imageBuilder: (context, imageProvioder) {
                        //     return Container(
                        //       decoration: BoxDecoration(
                        //         image: DecorationImage(image: imageProvioder, fit: BoxFit.fill),
                        //       ),
                        //     );
                        //   },
                        //   placeholder: (context, url) => Container(
                        //       width: 50,
                        //       height: 50,
                        //       alignment: Alignment.center,
                        //       child: SizedBox(
                        //         height: 30,
                        //         width: 30,
                        //         child: CircularProgressIndicator(),
                        //       )),
                        //   errorWidget: (context, url, error) => Icon(Icons.error),
                        // ),
                        child: Image.asset(
                          url,
                          fit: BoxFit.fitWidth,
                          width: Get.width,
                          height: Get.height,
                        ),
                      ),
                    );
                  },
                ).toList(),
                options: CarouselOptions(
                  height: 200,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.decelerate,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  padEnds: true,
                  animateToClosest: true,
                  pageSnapping: true,
                  scrollDirection: Axis.horizontal,
                )),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10, top: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(prefixIcon: Icon(Icons.search), enabledBorder: OutlineInputBorder(), labelText: "Search"),
                  ),
                  gapHC(15),
                  Row(
                    children: [Text("Category"), Spacer(), Text("View All")],
                  ),
                  gapHC(15),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 7,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(border: Border.all(width: .1), borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          width: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 40,
                                decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/icons/burger.png"))),
                              ),
                              gapHC(5),
                              Text("Burger")
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  gapHC(15),
                  Row(
                    children: [Text("Menu Item"), Spacer(), Text("View All")],
                  ),
                  gapHC(15),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisSpacing: 10, crossAxisCount: 2, childAspectRatio: .8, crossAxisSpacing: 10),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(border: Border.all(width: .1), borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/item_image/burger.jpg"))),
                            ),
                            Text("Buger"),
                            Text("150")
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
