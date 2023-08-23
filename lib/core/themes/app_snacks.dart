
import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> sucessSnackBar(
  String title,
  BuildContext context,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(title),
        backgroundColor: const Color(0xff50ED57),
      ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> failSnackBar(
  String title,
  BuildContext context,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
        content: Text(title),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
  );
}