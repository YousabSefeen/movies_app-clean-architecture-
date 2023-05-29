import 'package:flutter/material.dart';

class ShowLoadingWidget extends StatelessWidget {
  const ShowLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
