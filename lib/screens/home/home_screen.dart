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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(border: Border.all(width: .2), borderRadius: BorderRadius.circular(100)),
                      padding: EdgeInsets.all(15),
                      child: Icon(Icons.person),
                    ),
                    gapWC(10),
                    Text(
                      "Hi User...",
                      style: TextStyle(color: Color(0xFF353CAC), fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Spacer(),
                    Icon(Icons.notifications),
                    gapWC(5)
                  ],
                ),
              ),
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
                    height: 180,
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
                    SizedBox(
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(width: .2)),
                            prefixIcon: Icon(Icons.search),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(width: .2)),
                            hintText: "Search for menu item"),
                      ),
                    ),
                    gapHC(15),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Category",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Spacer(),
                        Text("View All")
                      ],
                    ),
                    gapHC(15),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: homeController.menuItems.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundColor: Colors.indigo,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 35,
                                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(homeController.menuItems[index]["image"]))),
                                      ),
                                    ],
                                  ),
                                ),
                                gapHC(5),
                                Text(
                                  homeController.menuItems[index]["title"],
                                  style: TextStyle(color: Colors.black, fontSize: 12),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    gapHC(15),
                    Row(
                      children: [
                        Text(
                          "Items",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Spacer(),
                        Text("View All")
                      ],
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
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                  "assets/item_image/burger.jpg",
                                ))),
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
      ),
    );
  }
}
