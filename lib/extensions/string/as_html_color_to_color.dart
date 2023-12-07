
import 'package:flutter/material.dart';
import 'package:instagram_clone/extensions/string/remove_all.dart';

extension AsHtmlColorToColor on String {
  Color htmlColorToColor() => Color(
    int.parse(
      removeAll(['#']).padLeft(7, '0xFF')
    )
  );
}