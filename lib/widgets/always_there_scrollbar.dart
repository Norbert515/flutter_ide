import 'dart:async';

import 'package:flutter/material.dart';

const double _kScrollbarThickness = 6.0;
const Duration _kScrollbarFadeDuration = Duration(milliseconds: 300);
const Duration _kScrollbarTimeToFade = Duration(milliseconds: 600);

/// A material design scrollbar.
///
/// A scrollbar indicates which portion of a [Scrollable] widget is actually
/// visible.
///
/// Dynamically changes to an iOS style scrollbar that looks like
/// [CupertinoScrollbar] on the iOS platform.
///
/// To add a scrollbar to a [ScrollView], simply wrap the scroll view widget in
/// a [Scrollbar] widget.
///
/// See also:
///
///  * [ListView], which display a linear, scrollable list of children.
///  * [GridView], which display a 2 dimensional, scrollable array of children.
class StayScrollbar extends StatefulWidget {
  /// Creates a material design scrollbar that wraps the given [child].
  ///
  /// The [child] should be a source of [ScrollNotification] notifications,
  /// typically a [Scrollable] widget.
  const StayScrollbar({
    Key key,
    @required this.child,
  }) : super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// The scrollbar will be stacked on top of this child. This child (and its
  /// subtree) should include a source of [ScrollNotification] notifications.
  ///
  /// Typically a [ListView] or [CustomScrollView].
  final Widget child;

  @override
  _ScrollbarState createState() => _ScrollbarState();
}


class _ScrollbarState extends State<StayScrollbar> with TickerProviderStateMixin {
  ScrollbarPainter _materialPainter;
  TargetPlatform _currentPlatform;
  TextDirection _textDirection;
  Color _themeColor;

  Animation<double> _fadeoutOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _fadeoutOpacityAnimation = AlwaysStoppedAnimation(0.4);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final ThemeData theme = Theme.of(context);
    _currentPlatform = theme.platform;

    switch (_currentPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.iOS:
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        _themeColor = theme.highlightColor.withOpacity(1.0);
        _textDirection = Directionality.of(context);
        _materialPainter = _buildMaterialScrollbarPainter();
        break;
    }
  }

  ScrollbarPainter _buildMaterialScrollbarPainter() {
    return ScrollbarPainter(
      color: _themeColor,
      textDirection: _textDirection,
      thickness: _kScrollbarThickness,
      fadeoutOpacityAnimation: _fadeoutOpacityAnimation,
      padding: MediaQuery.of(context).padding,
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    // iOS sub-delegates to the CupertinoScrollbar instead and doesn't handle
    // scroll notifications here.
    if (_currentPlatform != TargetPlatform.iOS
        && (notification is ScrollUpdateNotification
            || notification is OverscrollNotification)) {

      _materialPainter.update(notification.metrics, notification.metrics.axisDirection);
    }
    return false;
  }

  @override
  void dispose() {
    _materialPainter?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: RepaintBoundary(
        child: CustomPaint(
          foregroundPainter: _materialPainter,
          child: RepaintBoundary(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}