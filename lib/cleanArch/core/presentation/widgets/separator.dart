import 'package:flutter/widgets.dart';

class Separator extends SizedBox {
  const Separator({double? width, double? height, super.key})
    : assert(
        (height == null) != (width == null),
        'Must set width or height, but not both or neither',
      ),
      super(width: width ?? 0, height: height ?? 0);

  const Separator.forRow(double width, {super.key}) : super(width: width);

  const Separator.forColumn(double height, {super.key}) : super(height: height);
}
