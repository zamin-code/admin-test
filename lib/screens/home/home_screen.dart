import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:my_resto/common.dart';
import 'package:my_resto/screens/detailed_item_view/detailed_shop_screen.dart';
import 'package:shimmer/shimmer.dart';

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
                      padding: const EdgeInsets.all(15),
                      child: const Icon(Icons.person),
                    ),
                    gapWC(10),
                    const Text(
                      "Hi Zamin...",
                      style: TextStyle(color: Color(0xFF353CAC), fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Spacer(),
                    const Icon(Icons.notifications),
                    gapWC(5)
                  ],
                ),
              ),
              CarouselSlider(
                  items: homeController.imgAds.map(
                    (url) {
                      return Container(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
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
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
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
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(width: .2)),
                            prefixIcon: const Icon(Icons.search),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(width: .2)),
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
                      child: AnimationLimiter(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: homeController.menuItems.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: Padding(
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
                                          style: const TextStyle(color: Colors.black, fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    gapHC(15),
                    const Row(
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
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasData || snapshot.data?.docs != null) {
                          return AnimationLimiter(
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(mainAxisSpacing: 5, crossAxisCount: 2, childAspectRatio: .77, crossAxisSpacing: 5),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    columnCount: snapshot.data!.docs.length,
                                    child: ScaleAnimation(
                                        child: FadeInAnimation(
                                      child: Card(
                                        color: Colors.white,
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              () => DetailedShopScreen(
                                                itemData: snapshot.data!.docs[index],
                                                index: index,
                                              ),
                                              transition: Transition.fadeIn,
                                            );
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                            width: 230,
                                            alignment: Alignment.center,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    Container(
                                                      width: 150,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                                        border: Border.all(width: 0.1),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                                        child: Hero(
                                                          tag: "Item/Image_${index}", // Ensure each tag is unique
                                                          child: CachedNetworkImage(
                                                            imageUrl: snapshot.data!.docs[index]["rep_image"],
                                                            fit: BoxFit.fill,
                                                            placeholder: (context, url) => Shimmer.fromColors(
                                                              baseColor: Colors.grey[300]!,
                                                              highlightColor: Colors.grey[100]!,
                                                              child: Container(
                                                                width: 150,
                                                                height: 100,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.grey[300],
                                                                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                                                ),
                                                              ),
                                                            ),
                                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 5,
                                                      right: 5,
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.indigo),
                                                        child: Text(
                                                          snapshot.data!.docs[index]["category"],
                                                          maxLines: 1,
                                                          style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w200),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                gapHC(10),
                                                AutoSizeText(
                                                  snapshot.data!.docs[index]["item_name"],
                                                  maxLines: 1,
                                                  style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                                ),
                                                gapHC(5),
                                                double.tryParse(snapshot.data!.docs[index]["offer_perc"].toString())! <= 0
                                                    ? Text(
                                                        "₹ ${double.tryParse(snapshot.data!.docs[index]["sell_amount"])?.toStringAsFixed(2)}",
                                                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1, color: Colors.orange),
                                                      )
                                                    : Row(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Text(
                                                                "₹ ${double.tryParse(snapshot.data!.docs[index]["price"].toString())?.toStringAsFixed(2)}",
                                                                style: const TextStyle(decorationThickness: 2.0, fontSize: 11, color: Colors.orange),
                                                              ),
                                                              const Positioned.fill(
                                                                  bottom: 1,
                                                                  child: Divider(
                                                                    color: Colors.orange,
                                                                    thickness: 2,
                                                                  ))
                                                            ],
                                                          ),
                                                          gapWC(5),
                                                          Text(
                                                            "₹${snapshot.data!.docs[index]["sell_amount"].toString()}",
                                                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 1, color: Colors.black),
                                                          ),
                                                          gapWC(10),
                                                          Column(
                                                            children: [
                                                              Center(
                                                                child: Container(
                                                                  padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.green),
                                                                  child: Text(
                                                                    "${snapshot.data!.docs[index]["offer_perc"].toString()}% OFF",
                                                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 7),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                gapHC(5),
                                                const Spacer(),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        snapshot.data!.docs[index]["details"].toString(),
                                                        maxLines: 2,
                                                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.normal, height: 1, color: Colors.grey),
                                                      ),
                                                    ),
                                                    gapWC(10),
                                                    const CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor: Color(0xFF520E0E),
                                                        child: Icon(
                                                          Icons.add_shopping_cart_outlined,
                                                          color: Colors.white,
                                                          size: 15,
                                                        ))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )));
                              },
                            ),
                          );
                        } else {
                          return const Text("Error");
                        }
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
