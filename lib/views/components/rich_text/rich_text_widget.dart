import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/views/components/rich_text/base_text.dart';
import 'package:instagram_clone/views/components/rich_text/link_text.dart';

class RichTextWidget extends StatelessWidget {
  final Iterable<BaseText> texts;
  final TextStyle? styleForAllTexts;

  const RichTextWidget({super.key, required this.texts, this.styleForAllTexts});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: texts.map((baseText) {
          if (baseText is LinkText) {
            return TextSpan(
              text: baseText.text,
              style: styleForAllTexts?.merge(baseText.style),
              recognizer: (TapGestureRecognizer()..onTap = baseText.onTapped)
            );
          } else {
            return TextSpan(
              text: baseText.text,
              style: baseText.style?.merge(styleForAllTexts),
            );
          }
        }).toList(),
      ),
    );
  }
}