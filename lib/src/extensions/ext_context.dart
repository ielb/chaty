import 'package:chaty/src/extensions/extensions.dart';

extension ScreenSize on BuildContext {
  /// screen size
  Size get size => MediaQuery.of(this).size;
}
