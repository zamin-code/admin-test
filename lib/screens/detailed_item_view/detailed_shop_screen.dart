import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_resto/common.dart';
import 'package:shimmer/shimmer.dart';

class DetailedShopScreen extends StatelessWidget {
  const DetailedShopScreen({super.key, required this.itemData, required this.index});
  final itemData;
  final int index;

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
          gapHC(30),
          Align(
            heightFactor: .81,
            child: SizedBox(
              width: Get.width,
              height: 300,
              child: ClipRRect(
                child: Hero(
                  tag: "Item/Image_${index}",
                  child: CachedNetworkImage(
                    imageUrl: itemData["rep_image"],
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
          ),
          animColumn([
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white),
              width: Get.width,
              padding: EdgeInsets.all(15),
              child: animColumn([
                Row(
                  children: [
                    AutoSizeText(
                      itemData["item_name"],
                      maxLines: 1,
                      style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Icon(Icons.favorite_border),
                    gapWC(10)
                  ],
                ),
                gapHC(10),
                AutoSizeText(
                  "${double.tryParse(itemData["sell_amount"])!.toStringAsFixed(2)}",
                  maxLines: 1,
                  style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ]),
            ),
          ]),
        ],
      )),
    );
  }
}
