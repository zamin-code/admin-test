import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class DetailedShopScreen extends StatelessWidget {
  const DetailedShopScreen({super.key, required this.ItemData, required this.indexx});
  final ItemData;
  final indexx;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBody: false,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: Get.width,
                  height: 300,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: Hero(
                      tag: "Item/Image_${indexx}",
                      child: CachedNetworkImage(
                        imageUrl: ItemData["rep_image"],
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: Get.width,
                      height: 260,
                    ),
                    AnimatedContainer(
                      duration: Duration(seconds: 5),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.blueGrey),
                      width: Get.width,
                      height: 200,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
