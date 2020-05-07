import 'package:flutter/material.dart' hide
WDuration,
TextStyle;

import 'package:widget_maker_2_0/data/widget_elements/generated/properties/fake_objects.dart';

abstract class Widget2 {
    Map<String, dynamic> toMap();
}


class Text extends Widget2{

    Text({
        this.id,
        this.data,
        this.overflow,
        this.textAlign,
        this.style,
    });

    final String id;


    final String data;
    final TextOverflow overflow;
    final TextAlign textAlign;
    final TextStyle style;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "Text",
            "data": this.data?.toMap(),
            "overflow": this.overflow?.toMap(),
            "textAlign": this.textAlign?.toMap(),
            "style": this.style?.toMap(),

        };
    }
}

class AppBar extends Widget2{

    AppBar({
        this.id,
        this.title,
        this.leading,
        this.automaticallyImplyLeading,
        this.backgroundColor,
        this.brightness,
        this.bottomOpacity,
        this.toolbarOpacity,
        this.centerTitle,
        this.titleSpacing,
        this.primary,
        this.elevation,
    });

    final String id;

    final Widget2 title;
    final Widget2 leading;

    final bool automaticallyImplyLeading;
    final Color backgroundColor;
    final Brightness brightness;
    final double bottomOpacity;
    final double toolbarOpacity;
    final bool centerTitle;
    final double titleSpacing;
    final bool primary;
    final double elevation;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "AppBar",
            "automaticallyImplyLeading": this.automaticallyImplyLeading?.toMap(),
            "backgroundColor": this.backgroundColor?.toMap(),
            "brightness": this.brightness?.toMap(),
            "bottomOpacity": this.bottomOpacity?.toMap(),
            "toolbarOpacity": this.toolbarOpacity?.toMap(),
            "centerTitle": this.centerTitle?.toMap(),
            "titleSpacing": this.titleSpacing?.toMap(),
            "primary": this.primary?.toMap(),
            "elevation": this.elevation?.toMap(),

            "title": this.title.toMap(),
            "leading": this.leading.toMap(),
        };
    }
}

class CupertinoNavigationBar extends Widget2{

    CupertinoNavigationBar({
        this.id,
        this.leading,
        this.middle,
        this.trailing,
        this.backgroundColor,
    });

    final String id;

    final Widget2 leading;
    final Widget2 middle;
    final Widget2 trailing;

    final Color backgroundColor;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "CupertinoNavigationBar",
            "backgroundColor": this.backgroundColor?.toMap(),

            "leading": this.leading.toMap(),
            "middle": this.middle.toMap(),
            "trailing": this.trailing.toMap(),
        };
    }
}

class Icon extends Widget2{

    Icon({
        this.id,
        this.icon,
        this.size,
        this.color,
    });

    final String id;


    final IconData icon;
    final double size;
    final Color color;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "Icon",
            "icon": this.icon?.toMap(),
            "size": this.size?.toMap(),
            "color": this.color?.toMap(),

        };
    }
}

class Form extends Widget2{

    Form({
        this.id,
        this.child,
    });

    final String id;

    final Widget2 child;



    Map<String, dynamic> toMap() {
        return {
            "&&type": "Form",

            "child": this.child.toMap(),
        };
    }
}

class Material extends Widget2{

    Material({
        this.id,
        this.child,
    });

    final String id;

    final Widget2 child;



    Map<String, dynamic> toMap() {
        return {
            "&&type": "Material",

            "child": this.child.toMap(),
        };
    }
}

class Flexible extends Widget2{

    Flexible({
        this.id,
        this.child,
        this.flex,
    });

    final String id;

    final Widget2 child;

    final int flex;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "Flexible",
            "flex": this.flex?.toMap(),

            "child": this.child.toMap(),
        };
    }
}

class TextFormField extends Widget2{

    TextFormField({
        this.id,
    });

    final String id;




    Map<String, dynamic> toMap() {
        return {
            "&&type": "TextFormField",

        };
    }
}

class GestureDetector extends Widget2{

    GestureDetector({
        this.id,
        this.child,
    });

    final String id;

    final Widget2 child;



    Map<String, dynamic> toMap() {
        return {
            "&&type": "GestureDetector",

            "child": this.child.toMap(),
        };
    }
}

class WNetworkImage extends Widget2{

    WNetworkImage({
        this.id,
        this.width,
        this.height,
        this.src,
        this.fit,
    });

    final String id;


    final double width;
    final double height;
    final String src;
    final BoxFit fit;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "WNetworkImage",
            "width": this.width?.toMap(),
            "height": this.height?.toMap(),
            "src": this.src?.toMap(),
            "fit": this.fit?.toMap(),

        };
    }
}

class SizedBox extends Widget2{

    SizedBox({
        this.id,
        this.child,
        this.width,
        this.height,
    });

    final String id;

    final Widget2 child;

    final double width;
    final double height;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "SizedBox",
            "width": this.width?.toMap(),
            "height": this.height?.toMap(),

            "child": this.child.toMap(),
        };
    }
}

class CircularProgressIndicator extends Widget2{

    CircularProgressIndicator({
        this.id,
        this.strokeWidth,
        this.backgroundColor,
    });

    final String id;


    final double strokeWidth;
    final Color backgroundColor;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "CircularProgressIndicator",
            "strokeWidth": this.strokeWidth?.toMap(),
            "backgroundColor": this.backgroundColor?.toMap(),

        };
    }
}

class LinearProgressIndicator extends Widget2{

    LinearProgressIndicator({
        this.id,
    });

    final String id;




    Map<String, dynamic> toMap() {
        return {
            "&&type": "LinearProgressIndicator",

        };
    }
}

class CupertinoActivityIndicator extends Widget2{

    CupertinoActivityIndicator({
        this.id,
        this.animating,
        this.radius,
    });

    final String id;


    final bool animating;
    final double radius;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "CupertinoActivityIndicator",
            "animating": this.animating?.toMap(),
            "radius": this.radius?.toMap(),

        };
    }
}

class FloatingActionButton extends Widget2{

    FloatingActionButton({
        this.id,
        this.child,
        this.elevation,
        this.tooltip,
        this.foregroundColor,
        this.backgroundColor,
        this.focusColor,
        this.hoverColor,
        this.onPressed,
    });

    final String id;

    final Widget2 child;

    final double elevation;
    final String tooltip;
    final Color foregroundColor;
    final Color backgroundColor;
    final Color focusColor;
    final Color hoverColor;
    final VoidCallback onPressed;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "FloatingActionButton",
            "elevation": this.elevation?.toMap(),
            "tooltip": this.tooltip?.toMap(),
            "foregroundColor": this.foregroundColor?.toMap(),
            "backgroundColor": this.backgroundColor?.toMap(),
            "focusColor": this.focusColor?.toMap(),
            "hoverColor": this.hoverColor?.toMap(),
            "onPressed": this.onPressed?.toMap(),

            "child": this.child.toMap(),
        };
    }
}

class Scaffold extends Widget2{

    Scaffold({
        this.id,
        this.body,
        this.appBar,
        this.floatingActionButton,
        this.backgroundColor,
    });

    final String id;

    final Widget2 body;
    final Widget2 appBar;
    final Widget2 floatingActionButton;

    final Color backgroundColor;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "Scaffold",
            "backgroundColor": this.backgroundColor?.toMap(),

            "body": this.body.toMap(),
            "appBar": this.appBar.toMap(),
            "floatingActionButton": this.floatingActionButton.toMap(),
        };
    }
}

class ListTile extends Widget2{

    ListTile({
        this.id,
        this.leading,
        this.title,
        this.subtitle,
        this.trailing,
        this.isThreeLine,
        this.dense,
        this.contentPadding,
        this.enabled,
    });

    final String id;

    final Widget2 leading;
    final Widget2 title;
    final Widget2 subtitle;
    final Widget2 trailing;

    final bool isThreeLine;
    final bool dense;
    final EdgeInsets contentPadding;
    final bool enabled;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "ListTile",
            "isThreeLine": this.isThreeLine?.toMap(),
            "dense": this.dense?.toMap(),
            "contentPadding": this.contentPadding?.toMap(),
            "enabled": this.enabled?.toMap(),

            "leading": this.leading.toMap(),
            "title": this.title.toMap(),
            "subtitle": this.subtitle.toMap(),
            "trailing": this.trailing.toMap(),
        };
    }
}

class Center extends Widget2{

    Center({
        this.id,
        this.child,
    });

    final String id;

    final Widget2 child;



    Map<String, dynamic> toMap() {
        return {
            "&&type": "Center",

            "child": this.child.toMap(),
        };
    }
}

class Padding extends Widget2{

    Padding({
        this.id,
        this.child,
        this.padding,
    });

    final String id;

    final Widget2 child;

    final EdgeInsets padding;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "Padding",
            "padding": this.padding?.toMap(),

            "child": this.child.toMap(),
        };
    }
}

class RotatedBox extends Widget2{

    RotatedBox({
        this.id,
        this.child,
        this.quarterTurns,
    });

    final String id;

    final Widget2 child;

    final int quarterTurns;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "RotatedBox",
            "quarterTurns": this.quarterTurns?.toMap(),

            "child": this.child.toMap(),
        };
    }
}

class AspectRatio extends Widget2{

    AspectRatio({
        this.id,
        this.child,
        this.aspectRatio,
    });

    final String id;

    final Widget2 child;

    final double aspectRatio;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "AspectRatio",
            "aspectRatio": this.aspectRatio?.toMap(),

            "child": this.child.toMap(),
        };
    }
}

class TextField extends Widget2{

    TextField({
        this.id,
        this.obscureText,
    });

    final String id;


    final bool obscureText;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "TextField",
            "obscureText": this.obscureText?.toMap(),

        };
    }
}

class FractionallySizedBox extends Widget2{

    FractionallySizedBox({
        this.id,
        this.child,
        this.heightFactor,
        this.widthFactor,
        this.alignment,
    });

    final String id;

    final Widget2 child;

    final double heightFactor;
    final double widthFactor;
    final Alignment alignment;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "FractionallySizedBox",
            "heightFactor": this.heightFactor?.toMap(),
            "widthFactor": this.widthFactor?.toMap(),
            "alignment": this.alignment?.toMap(),

            "child": this.child.toMap(),
        };
    }
}

class Divider extends Widget2{

    Divider({
        this.id,
        this.height,
        this.indent,
        this.endIndent,
        this.color,
    });

    final String id;


    final double height;
    final double indent;
    final double endIndent;
    final Color color;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "Divider",
            "height": this.height?.toMap(),
            "indent": this.indent?.toMap(),
            "endIndent": this.endIndent?.toMap(),
            "color": this.color?.toMap(),

        };
    }
}

class Align extends Widget2{

    Align({
        this.id,
        this.child,
        this.heightFactor,
        this.widthFactor,
        this.alignment,
    });

    final String id;

    final Widget2 child;

    final double heightFactor;
    final double widthFactor;
    final Alignment alignment;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "Align",
            "heightFactor": this.heightFactor?.toMap(),
            "widthFactor": this.widthFactor?.toMap(),
            "alignment": this.alignment?.toMap(),

            "child": this.child.toMap(),
        };
    }
}

class UnconstrainedBox extends Widget2{

    UnconstrainedBox({
        this.id,
        this.child,
        this.constrainedAxis,
        this.textDirection,
        this.alignment,
    });

    final String id;

    final Widget2 child;

    final Axis constrainedAxis;
    final TextDirection textDirection;
    final Alignment alignment;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "UnconstrainedBox",
            "constrainedAxis": this.constrainedAxis?.toMap(),
            "textDirection": this.textDirection?.toMap(),
            "alignment": this.alignment?.toMap(),

            "child": this.child.toMap(),
        };
    }
}

class ConstrainedBox extends Widget2{

    ConstrainedBox({
        this.id,
        this.child,
        this.constraints,
    });

    final String id;

    final Widget2 child;

    final BoxConstraints constraints;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "ConstrainedBox",
            "constraints": this.constraints?.toMap(),

            "child": this.child.toMap(),
        };
    }
}

class WContainer extends Widget2{

    WContainer({
        this.id,
        this.child,
        this.width,
        this.height,
        this.color,
        this.alignment,
        this.padding,
        this.decoration,
        this.foregroundDecoration,
        this.constraints,
        this.margin,
        this.transform,
    });

    final String id;

    final Widget2 child;

    final double width;
    final double height;
    final Color color;
    final Alignment alignment;
    final EdgeInsets padding;
    final Decoration decoration;
    final Decoration foregroundDecoration;
    final BoxConstraints constraints;
    final EdgeInsets margin;
    final Matrix4 transform;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "WContainer",
            "width": this.width?.toMap(),
            "height": this.height?.toMap(),
            "color": this.color?.toMap(),
            "alignment": this.alignment?.toMap(),
            "padding": this.padding?.toMap(),
            "decoration": this.decoration?.toMap(),
            "foregroundDecoration": this.foregroundDecoration?.toMap(),
            "constraints": this.constraints?.toMap(),
            "margin": this.margin?.toMap(),
            "transform": this.transform?.toMap(),

            "child": this.child.toMap(),
        };
    }
}

class AbsorbPointer extends Widget2{

    AbsorbPointer({
        this.id,
        this.child,
    });

    final String id;

    final Widget2 child;



    Map<String, dynamic> toMap() {
        return {
            "&&type": "AbsorbPointer",

            "child": this.child.toMap(),
        };
    }
}

class WCircleAvatar extends Widget2{

    WCircleAvatar({
        this.id,
        this.child,
        this.radius,
        this.imageUrl,
    });

    final String id;

    final Widget2 child;

    final double radius;
    final String imageUrl;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "WCircleAvatar",
            "radius": this.radius?.toMap(),
            "imageUrl": this.imageUrl?.toMap(),

            "child": this.child.toMap(),
        };
    }
}

class Card extends Widget2{

    Card({
        this.id,
        this.child,
        this.clipBehavior,
        this.color,
        this.elevation,
        this.margin,
        this.semanticContainer,
    });

    final String id;

    final Widget2 child;

    final Clip clipBehavior;
    final Color color;
    final double elevation;
    final EdgeInsets margin;
    final bool semanticContainer;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "Card",
            "clipBehavior": this.clipBehavior?.toMap(),
            "color": this.color?.toMap(),
            "elevation": this.elevation?.toMap(),
            "margin": this.margin?.toMap(),
            "semanticContainer": this.semanticContainer?.toMap(),

            "child": this.child.toMap(),
        };
    }
}

class Checkbox extends Widget2{

    Checkbox({
        this.id,
        this.activeColor,
        this.checkColor,
        this.tristate,
        this.value,
    });

    final String id;


    final Color activeColor;
    final Color checkColor;
    final bool tristate;
    final bool value;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "Checkbox",
            "activeColor": this.activeColor?.toMap(),
            "checkColor": this.checkColor?.toMap(),
            "tristate": this.tristate?.toMap(),
            "value": this.value?.toMap(),

        };
    }
}

class Chip extends Widget2{

    Chip({
        this.id,
        this.avatar,
        this.deleteIcon,
        this.label,
        this.backgroundColor,
        this.clipBehavior,
        this.deleteButtonTooltipMessage,
        this.deleteIconColor,
        this.elevation,
        this.labelPadding,
        this.labelStyle,
        this.padding,
        this.shadowColor,
    });

    final String id;

    final Widget2 avatar;
    final Widget2 deleteIcon;
    final Widget2 label;

    final Color backgroundColor;
    final Clip clipBehavior;
    final String deleteButtonTooltipMessage;
    final Color deleteIconColor;
    final double elevation;
    final EdgeInsets labelPadding;
    final TextStyle labelStyle;
    final EdgeInsets padding;
    final Color shadowColor;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "Chip",
            "backgroundColor": this.backgroundColor?.toMap(),
            "clipBehavior": this.clipBehavior?.toMap(),
            "deleteButtonTooltipMessage": this.deleteButtonTooltipMessage?.toMap(),
            "deleteIconColor": this.deleteIconColor?.toMap(),
            "elevation": this.elevation?.toMap(),
            "labelPadding": this.labelPadding?.toMap(),
            "labelStyle": this.labelStyle?.toMap(),
            "padding": this.padding?.toMap(),
            "shadowColor": this.shadowColor?.toMap(),

            "avatar": this.avatar.toMap(),
            "deleteIcon": this.deleteIcon.toMap(),
            "label": this.label.toMap(),
        };
    }
}

class WPageView extends Widget2{

    WPageView({
        this.id,
        this.children,
        this.pageSnapping,
    });

    final String id;

    final List<Widget> children;

    final bool pageSnapping;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "WPageView",
            "pageSnapping": this.pageSnapping?.toMap(),

            "children": this.children.map((it) => it.toMap()).toList(),
        };
    }
}

class Column extends Widget2{

    Column({
        this.id,
        this.children,
        this.crossAxisAlignment,
        this.mainAxisSize,
        this.mainAxisAlignment,
    });

    final String id;

    final List<Widget> children;

    final CrossAxisAlignment crossAxisAlignment;
    final MainAxisSize mainAxisSize;
    final MainAxisAlignment mainAxisAlignment;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "Column",
            "crossAxisAlignment": this.crossAxisAlignment?.toMap(),
            "mainAxisSize": this.mainAxisSize?.toMap(),
            "mainAxisAlignment": this.mainAxisAlignment?.toMap(),

            "children": this.children.map((it) => it.toMap()).toList(),
        };
    }
}

class Row extends Widget2{

    Row({
        this.id,
        this.children,
        this.crossAxisAlignment,
        this.mainAxisSize,
        this.mainAxisAlignment,
        this.textBaseline,
        this.textDirection,
    });

    final String id;

    final List<Widget> children;

    final CrossAxisAlignment crossAxisAlignment;
    final MainAxisSize mainAxisSize;
    final MainAxisAlignment mainAxisAlignment;
    final TextBaseline textBaseline;
    final TextDirection textDirection;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "Row",
            "crossAxisAlignment": this.crossAxisAlignment?.toMap(),
            "mainAxisSize": this.mainAxisSize?.toMap(),
            "mainAxisAlignment": this.mainAxisAlignment?.toMap(),
            "textBaseline": this.textBaseline?.toMap(),
            "textDirection": this.textDirection?.toMap(),

            "children": this.children.map((it) => it.toMap()).toList(),
        };
    }
}

class Expanded extends Widget2{

    Expanded({
        this.id,
        this.child,
        this.flex,
    });

    final String id;

    final Widget2 child;

    final int flex;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "Expanded",
            "flex": this.flex?.toMap(),

            "child": this.child.toMap(),
        };
    }
}

class MaterialButton extends Widget2{

    MaterialButton({
        this.id,
        this.child,
        this.color,
        this.elevation,
        this.padding,
    });

    final String id;

    final Widget2 child;

    final Color color;
    final double elevation;
    final EdgeInsets padding;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "MaterialButton",
            "color": this.color?.toMap(),
            "elevation": this.elevation?.toMap(),
            "padding": this.padding?.toMap(),

            "child": this.child.toMap(),
        };
    }
}

class OutlineButton extends Widget2{

    OutlineButton({
        this.id,
        this.child,
        this.color,
        this.padding,
    });

    final String id;

    final Widget2 child;

    final Color color;
    final EdgeInsets padding;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "OutlineButton",
            "color": this.color?.toMap(),
            "padding": this.padding?.toMap(),

            "child": this.child.toMap(),
        };
    }
}

class RaisedButton extends Widget2{

    RaisedButton({
        this.id,
        this.child,
        this.elevation,
        this.padding,
        this.color,
    });

    final String id;

    final Widget2 child;

    final double elevation;
    final EdgeInsets padding;
    final Color color;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "RaisedButton",
            "elevation": this.elevation?.toMap(),
            "padding": this.padding?.toMap(),
            "color": this.color?.toMap(),

            "child": this.child.toMap(),
        };
    }
}

class CupertinoButton extends Widget2{

    CupertinoButton({
        this.id,
        this.child,
        this.color,
        this.disabledColor,
        this.minSize,
        this.padding,
        this.pressedOpacity,
    });

    final String id;

    final Widget2 child;

    final Color color;
    final Color disabledColor;
    final double minSize;
    final EdgeInsets padding;
    final double pressedOpacity;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "CupertinoButton",
            "color": this.color?.toMap(),
            "disabledColor": this.disabledColor?.toMap(),
            "minSize": this.minSize?.toMap(),
            "padding": this.padding?.toMap(),
            "pressedOpacity": this.pressedOpacity?.toMap(),

            "child": this.child.toMap(),
        };
    }
}

class WAnimatedContainer extends Widget2{

    WAnimatedContainer({
        this.id,
        this.child,
        this.duration,
        this.width,
        this.height,
        this.color,
        this.alignment,
        this.padding,
        this.decoration,
        this.foregroundDecoration,
        this.constraints,
        this.margin,
        this.transform,
    });

    final String id;

    final Widget2 child;

    final WDuration duration;
    final double width;
    final double height;
    final Color color;
    final Alignment alignment;
    final EdgeInsets padding;
    final Decoration decoration;
    final Decoration foregroundDecoration;
    final BoxConstraints constraints;
    final EdgeInsets margin;
    final Matrix4 transform;


    Map<String, dynamic> toMap() {
        return {
            "&&type": "WAnimatedContainer",
            "duration": this.duration?.toMap(),
            "width": this.width?.toMap(),
            "height": this.height?.toMap(),
            "color": this.color?.toMap(),
            "alignment": this.alignment?.toMap(),
            "padding": this.padding?.toMap(),
            "decoration": this.decoration?.toMap(),
            "foregroundDecoration": this.foregroundDecoration?.toMap(),
            "constraints": this.constraints?.toMap(),
            "margin": this.margin?.toMap(),
            "transform": this.transform?.toMap(),

            "child": this.child.toMap(),
        };
    }
}
