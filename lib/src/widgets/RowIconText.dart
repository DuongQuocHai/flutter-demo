import 'package:flutter/material.dart';

class RowIconText extends StatelessWidget {
  final String text;
  final IconData iconName;
  final Color colorIcon;
  final TextStyle textStyle;
  final TextStyle subTextStyle;

  RowIconText({
    Key key,
    @required this.text,
    @required this.iconName,
    this.colorIcon,
    this.textStyle,
    this.subTextStyle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(
            iconName,
            color: colorIcon,
            size: 20.0,
            semanticLabel: 'Text to announce in accessibility modes',
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
