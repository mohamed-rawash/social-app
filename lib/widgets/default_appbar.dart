import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../uitl/constance.dart';

Widget DefaultAppBar({required BuildContext context, String? title, List<Widget>? action}) {
  return AppBar(
    title: title==null?Container(): Text(
      title,
      style: Theme.of(context).textTheme.bodyText1,
    ),
    titleSpacing: 0.0,
    leading: IconButton(
      icon: const FaIcon(FontAwesomeIcons.angleLeft, size: 24, color: primaryColor,),
      splashRadius: 24.0,
      onPressed: () => Navigator.pop(context),
    ),
    actions: action,
  );
}