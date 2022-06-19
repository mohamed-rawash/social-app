import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../uitl/constance.dart';

class LodingIndicat extends StatelessWidget {
  const LodingIndicat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoadingIndicator(
        indicatorType: Indicator.ballSpinFadeLoader, /// Required, The loading type of the widget
        colors: [
          Color(0xFF2a5c73),
          Color(0xFF3c7f98),
          Color(0xFF4ea6be),
        ],       /// Optional, The color collections
        strokeWidth: 1,                     /// Optional, The stroke of the line, only applicable to widget which contains line
        backgroundColor: Colors.transparent,      /// Optional, Background of the widget
        pathBackgroundColor: Colors.transparent   /// Optional, the stroke backgroundColor
    );
  }
}


Future showDialogW({required BuildContext context, required Widget content}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 200,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: accentColor,
        ),
        child: content,
      ),
    ),
  );
}