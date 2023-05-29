import 'package:flutter/material.dart';

import '../../../core/utils/app_constants.dart';

class ShowErrorWidget extends StatelessWidget {
  const ShowErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.2,
      child: const Center(
        child: Text(
          'An error occurred please try again later',
          style: TextStyle(
            fontSize: 30,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
