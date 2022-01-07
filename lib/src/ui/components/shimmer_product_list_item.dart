import 'package:flutter/material.dart';
import 'package:tawfeer/src/ui/components/shimmer_skeleton.dart';

class ShimmerProductListItem extends StatelessWidget {
  const ShimmerProductListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color baseColor = Colors.grey[300]!;
    Color highlightColor = const Color(0xFFebebeb);
    return Stack(
      alignment: Alignment.center,
      children: [
        const ShimmerSkeleton(
          width: double.infinity,
          height: 82.0,
          baseColor: Color(0xFFededed),
          highlightColor: Color(0xFFededed),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 9.0,
                top: 9.0,
                bottom: 9.0,
                right: 12,
              ),
              child: ShimmerSkeleton(
                width: 65,
                height: 65,
                baseColor: baseColor,
                highlightColor: highlightColor,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerSkeleton(
                    width: 150,
                    height: 6,
                    baseColor: Colors.grey[300]!,
                    highlightColor: highlightColor,
                  ),
                  const SizedBox(height: 12),
                  ShimmerSkeleton(
                    width: 80,
                    height: 6,
                    baseColor: Colors.grey[300]!,
                    highlightColor: highlightColor,
                  ),
                  const SizedBox(height: 12),
                  ShimmerSkeleton(
                    width: 100,
                    height: 6,
                    baseColor: Colors.grey[300]!,
                    highlightColor: highlightColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
