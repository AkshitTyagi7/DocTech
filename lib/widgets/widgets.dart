import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget AppNetworkImage(String url, {double? height, double? width, BoxFit? fit, double? radius}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius ?? 8),
      color: Colors.grey,
      image: DecorationImage(
        image: CachedNetworkImageProvider(url),
        fit: fit ?? BoxFit.cover,
      ),
    ),
  );
}
