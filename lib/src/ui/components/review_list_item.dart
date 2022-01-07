import 'package:flutter/material.dart';
import 'package:tawfeer/src/business_logic/models/review.dart';
import 'package:tawfeer/src/business_logic/shared/shared.dart';
import 'package:tawfeer/src/ui/themes/styles/colors.dart';

class ReviewListItem extends StatelessWidget {
  const ReviewListItem({Key? key, required this.review}) : super(key: key);

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: _userImg(context),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review.ownerFullName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(review.comment),
            ],
          ),
        ),
      ],
    );
  }

  Widget _userImg(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundImage: review.ownerImgUrl != null
          ? NetworkImage(
              Shared.baseURL + '/' + review.ownerImgUrl!,
            ) as ImageProvider
          : const AssetImage('assets/images/tawfeer_logo.png'),
      onBackgroundImageError: (Object exception, StackTrace? stackTrace) {},
      backgroundColor: MyColors.lightGrey,
    );
  }
}
