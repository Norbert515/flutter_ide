import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WCircleAvatar extends StatelessWidget {

  const WCircleAvatar({
    Key key,
    this.child,
    this.backgroundColor,
    this.imageUrl,
    this.foregroundColor,
    this.radius,
    this.minRadius,
    this.maxRadius,
  });

  final Widget child;
  final Color backgroundColor;
  final String imageUrl;
  final Color foregroundColor;
  final double radius;
  final double minRadius;
  final double maxRadius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: child,
      backgroundColor: backgroundColor,
      backgroundImage: null,
      foregroundColor: foregroundColor,
      maxRadius: maxRadius,
      minRadius: minRadius,
      radius: radius,
    );
  }
}

class WNetworkImage extends StatelessWidget {

  const WNetworkImage(
    this.src, {
    Key key,
    this.scale = 1.0,
    this.frameBuilder,
    this.loadingBuilder,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.filterQuality = FilterQuality.low,
    this.headers,
    this.cacheWidth,
    this.cacheHeight,
  }): super(key: key);


  final String src;
  final double scale;
  final ImageFrameBuilder frameBuilder;
  final ImageLoadingBuilder loadingBuilder;
  final String semanticLabel;
  final bool excludeFromSemantics;
  final double width;
  final double height;
  final Color color;
  final BlendMode colorBlendMode;
  final BoxFit fit;
  final Alignment alignment;
  final ImageRepeat repeat;
  final Rect centerSlice;
  final bool matchTextDirection;
  final bool gaplessPlayback;
  final FilterQuality filterQuality;
  final Map<String, String> headers;
  final int cacheWidth;
  final int cacheHeight;

  @override
  Widget build(BuildContext context) {
    return Image.network(src,
      scale: scale,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      filterQuality: filterQuality,
      headers: headers,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }
}

class WContainer extends StatelessWidget {

  const WContainer({
    Key key,
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.margin,
    this.transform,
    this.child,
  }): super(key: key);


  final Alignment alignment;
  final EdgeInsetsGeometry padding;
  final Color color;
  final Decoration decoration;
  final Decoration foregroundDecoration;
  final double width;
  final double height;
  final BoxConstraints constraints;
  final EdgeInsetsGeometry margin;
  final Matrix4 transform;
  final Widget child;


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: padding,
      color: color,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      transform: transform,
      child: child,
    );
  }
}

class WAnimatedContainer extends StatelessWidget {

  const WAnimatedContainer({
    Key key,
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.margin,
    this.transform,
    this.child,
    this.curve = Curves.linear,
    @required this.duration,
    this.onEnd,
  }): super(key: key);

  final Alignment alignment;
  final EdgeInsetsGeometry padding;
  final Color color;
  final Decoration decoration;
  final Decoration foregroundDecoration;
  final double width;
  final double height;
  final BoxConstraints constraints;
  final EdgeInsetsGeometry margin;
  final Matrix4 transform;
  final Widget child;
  final Curve curve;
  final Duration duration;
  final VoidCallback onEnd;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: alignment,
      padding: padding,
      color: color,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      transform: transform,
      child: child,
      curve: curve,
      duration: duration,
      onEnd: onEnd,
    );
  }
}

class WPageView extends StatelessWidget {

  const WPageView({
    Key key,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    this.controller,
    this.physics,
    this.pageSnapping = true,
    this.onPageChanged,
    this.children = const <Widget>[],
    this.dragStartBehavior = DragStartBehavior.start,
  });

  final Axis scrollDirection;
  final bool reverse;
  final PageController controller;
  final ScrollPhysics physics;
  final bool pageSnapping;
  final ValueChanged<int> onPageChanged;
  final List<Widget> children;
  final DragStartBehavior dragStartBehavior;


  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: scrollDirection,
      reverse: reverse,
      controller: controller,
      physics: physics,
      pageSnapping: pageSnapping,
      onPageChanged: onPageChanged,
      children: children,
      dragStartBehavior: dragStartBehavior,
    );
  }
}
