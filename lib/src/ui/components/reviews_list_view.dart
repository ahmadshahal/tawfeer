import 'package:flutter/material.dart';
import 'package:tawfeer/src/business_logic/models/review.dart';
import 'package:tawfeer/src/ui/components/review_list_item.dart';

class ReviewsListView extends StatelessWidget {
  const ReviewsListView({Key? key, required this.list}) : super(key: key);

  final List<Review> list;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return ReviewListItem(review: list[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 15.0);
      },
      itemCount: list.length,
    );
  }
}
