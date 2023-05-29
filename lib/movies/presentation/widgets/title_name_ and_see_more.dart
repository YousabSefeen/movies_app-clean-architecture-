import 'package:flutter/material.dart';

import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_strings.dart';

class TitleNameAndSeeMore extends StatelessWidget {
  final String title;
  final void Function()? seeMoreOnTap;
  final double fontSizeText;

  const TitleNameAndSeeMore({
    Key? key,
    required this.title,
    required this.seeMoreOnTap,
    required this.fontSizeText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textContext = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(
        top: height * 0.05,
        bottom: height * 0.02,
        left: width * 0.03,
        right: width * 0.03,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textContext.titleSmall!.copyWith(
              fontSize: fontSizeText,
            ),
          ),
          InkWell(
            onTap: seeMoreOnTap,
            child: Row(
              children: [
                Text(
                  AppStrings.seeMore,
                  style: textContext.titleSmall!.copyWith(
                    fontSize: width * 0.05,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blue,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
