import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'items.dart';

class BookItem extends StatelessWidget {
  const BookItem({Key? key, required this.listData, this.title = 'Title'})
      : super(key: key);
  final List<Items> listData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 0,
            child: Container(
              padding: const EdgeInsets.only(
                left: 50,
                bottom: 8,
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listData.length,
              padding: const EdgeInsets.symmetric(horizontal: 50),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  width: 149,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => Detail(
                      //       id: listData[index].itemid,
                      //       tagPrefix: tagPrefix,
                      //     ),
                      //   ),
                      // );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              color: Colors.grey.shade300,
                            ),
                            imageUrl: listData[index].imageid,
                            errorWidget: (context, error, _) => Container(
                              color: Colors.grey.shade300,
                            ),
                            width: 149,
                            height: 204,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          listData[index].title,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          listData[index].author,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
