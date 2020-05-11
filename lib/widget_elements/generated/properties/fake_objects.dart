import 'package:flutter/material.dart';

extension Converter on dynamic {
    dynamic toMap() {
        if(this is String || this is bool || this is double || this is int) {
            return this;
        } else if(this is MMProp) {
            return (this as MMProp).toMap();
        } else {
            return this.toString();
        }
    }
}

abstract class MMProp {

    const MMProp();
    Map<String, dynamic> toMap();
}
    class Offset extends MMProp {

        const Offset({
            this.dx,
            this.dy,
        });


        final double dx;
        final double dy;


        Map<String, dynamic> toMap() {
            return {
                 '&&type': 'Offset',
                 'dx': this.dx.toMap(),
                 'dy': this.dy.toMap(),
            };
        }

    }
    class WDuration extends MMProp {

        const WDuration({
            this.days,
            this.hours,
            this.minutes,
            this.seconds,
            this.milliseconds,
            this.microseconds,
        });


        final int days;
        final int hours;
        final int minutes;
        final int seconds;
        final int milliseconds;
        final int microseconds;


        Map<String, dynamic> toMap() {
            return {
                 '&&type': 'WDuration',
                 'days': this.days.toMap(),
                 'hours': this.hours.toMap(),
                 'minutes': this.minutes.toMap(),
                 'seconds': this.seconds.toMap(),
                 'milliseconds': this.milliseconds.toMap(),
                 'microseconds': this.microseconds.toMap(),
            };
        }

    }
    class TextStyle extends MMProp {

        const TextStyle({
            this.fontSize,
            this.inherit,
            this.color,
            this.backgroundColor,
            this.fontWeight,
            this.fontStyle,
            this.letterSpacing,
            this.wordSpacing,
            this.textBaseline,
            this.height,
        });


        final double fontSize;
        final bool inherit;
        final Color color;
        final Color backgroundColor;
        final FontWeight fontWeight;
        final FontStyle fontStyle;
        final double letterSpacing;
        final double wordSpacing;
        final TextBaseline textBaseline;
        final double height;


        Map<String, dynamic> toMap() {
            return {
                 '&&type': 'TextStyle',
                 'fontSize': this.fontSize.toMap(),
                 'inherit': this.inherit.toMap(),
                 'color': this.color.toMap(),
                 'backgroundColor': this.backgroundColor.toMap(),
                 'fontWeight': this.fontWeight.toMap(),
                 'fontStyle': this.fontStyle.toMap(),
                 'letterSpacing': this.letterSpacing.toMap(),
                 'wordSpacing': this.wordSpacing.toMap(),
                 'textBaseline': this.textBaseline.toMap(),
                 'height': this.height.toMap(),
            };
        }

    }
