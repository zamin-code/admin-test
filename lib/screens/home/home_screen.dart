import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                    StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("Items").snapshots(),
                      builder: (context, snapshot) {
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisSpacing: 5, crossAxisCount: 2, childAspectRatio: .7, crossAxisSpacing: 5),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            if (snapshot.hasData) {
                              return Card(
                                color: Colors.white,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  width: 230,
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 80,
                                        decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                  snapshot.data!.docs[index]["rep_image"],
                                                ))),
                                      ),
                                      gapHC(10),
                                      Text(
                                        snapshot.data!.docs[index]["item_name"],
                                        style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      gapHC(5),
                                      double.tryParse(snapshot.data!.docs[index]["offer_perc"].toString())! <= 0
                                          ? Text(
                                              "₹ ${double.tryParse(snapshot.data!.docs[index]["price"])?.toStringAsFixed(2)}",
                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1, color: Colors.orange),
                                            )
                                          : Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Stack(
                                                  children: [
                                                    Text(
                                                      "₹ ${double.tryParse(snapshot.data!.docs[index]["sell_amount"].toString())?.toStringAsFixed(2)}",
                                                      style: TextStyle(decorationThickness: 2.0, fontSize: 11, color: Colors.orange),
                                                    ),
                                                    Positioned.fill(
                                                        bottom: 1,
                                                        child: Divider(
                                                          color: Colors.orange,
                                                          thickness: 2,
                                                        ))
                                                  ],
                                                ),
                                                gapWC(5),
                                                Text(
                                                  "₹${snapshot.data!.docs[index]["offer_perc"].toString()}",
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 1, color: Colors.black),
                                                ),
                                                gapWC(10),
                                                Column(
                                                  children: [
                                                    Center(
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.indigo),
                                                        child: Text(
                                                          "${snapshot.data!.docs[index]["offer_perc"].toString()}% OFF",
                                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 7),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                      gapHC(5),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: AutoSizeText(
                                              snapshot.data!.docs[index]["details"].toString(),
                                              maxLines: 2,
                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, height: 1, color: Colors.grey),
                                            ),
                                          ),
                                          gapWC(10),
                                          const CircleAvatar(
                                              radius: 25,
                                              backgroundColor: Color(0xFF520E0E),
                                              child: Icon(
                                                Icons.add_shopping_cart_outlined,
                                                color: Colors.white,
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } else {}
                          },
                        );
                      },
                    )
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
