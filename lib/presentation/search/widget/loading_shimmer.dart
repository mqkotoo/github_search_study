import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import '../../../constants/color/app_color.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Shimmer.fromColors(
        period: const Duration(milliseconds: 750),
        baseColor: Theme.of(context).brightness == Brightness.light
            ? AppColor.lightBaseColor
            : AppColor.darkBaseColor,
        highlightColor: Theme.of(context).brightness == Brightness.light
            ? AppColor.lightHighlightColor
            : AppColor.darkHighlightColor,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: 20,
          itemBuilder: (context, index) => _listItem(),
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }

  Widget _listItem() {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          //title
          _shimmer(width: 150, height: 14),
          const SizedBox(height: 10)
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _shimmer(width: double.infinity, height: 12),
          const SizedBox(height: 5),
          _shimmer(width: double.infinity, height: 12)
        ],
      ),
    );
  }

  Widget _shimmer({required double width, required double height}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
    );
  }
}
