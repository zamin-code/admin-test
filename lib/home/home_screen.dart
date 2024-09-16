import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_resto/home/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HomeController homeController = HomeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                children: [Text("Menu Item"), Spacer(), Text("View All")],
              ),
            ),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisSpacing: 10, crossAxisCount: 2, crossAxisSpacing: 10),
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              physics: NeverScrollableScrollPhysics(),
              itemCount: 7,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(border: Border.all()),
                  alignment: Alignment.center,
                  child: Text(index.toString()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
