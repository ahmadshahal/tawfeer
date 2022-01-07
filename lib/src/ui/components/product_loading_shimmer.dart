import 'package:flutter/material.dart';
import 'package:tawfeer/src/ui/components/shimmer_skeleton.dart';
import 'package:tawfeer/src/ui/utils/non_glow_scroll_behavior.dart';

class ProductLoadingShimmer extends StatelessWidget {
  const ProductLoadingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color baseColor = const Color(0xFFededed);
    Color highlightColor = const Color(0xFFebebeb);
    return ScrollConfiguration(
      behavior: NonGlowScrollBehavior(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ShimmerSkeleton(
              width: double.infinity,
              radius: 0,
              height: MediaQuery.of(context).size.height / 2.2,
              baseColor: baseColor,
              highlightColor: highlightColor,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerSkeleton(
                        width: 180,
                        height: 7,
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                      ),
                      const SizedBox(height: 20),
                      ShimmerSkeleton(
                        width: 120,
                        height: 7,
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                ShimmerSkeleton(
                  width: 45,
                  height: 45,
                  radius: 200,
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                ),
                const SizedBox(width: 30),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ShimmerSkeleton(
                    width: 90,
                    height: 7,
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                  ),
                  ShimmerSkeleton(
                    width: 90,
                    height: 7,
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                  ),
                  ShimmerSkeleton(
                    width: 90,
                    height: 7,
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _detailsRow(context, baseColor, highlightColor, 120),
            const SizedBox(height: 30),
            _detailsRow(context, baseColor, highlightColor, 80),
            const SizedBox(height: 30),
            _detailsRow(context, baseColor, highlightColor, 90),
            const SizedBox(height: 30),
            _detailsRow(context, baseColor, highlightColor, 140),
            const SizedBox(height: 30),
            _detailsRow(context, baseColor, highlightColor, 140),
            const SizedBox(height: 30),
            _detailsRow(context, baseColor, highlightColor, 160),
            const SizedBox(height: 30),
            _detailsRow(context, baseColor, highlightColor, 160),
          ],
        ),
      ),
    );
  }

  Widget _detailsRow(BuildContext context, Color baseColor, Color highlightColor, double width) {
    return Row(
      children: [
        const SizedBox(width: 20),
        ShimmerSkeleton(
          width: 80,
          height: 7,
          baseColor: baseColor,
          highlightColor: highlightColor,
        ),
        const SizedBox(width: 40),
        ShimmerSkeleton(
          width: width,
          height: 7,
          baseColor: baseColor,
          highlightColor: highlightColor,
        ),
      ],
    );
  }
}
