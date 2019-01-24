
import 'package:flutter/material.dart';

mixin ValueChanger<T> {

  ValueChanged<T> get onUpdate;
  T get value;

}
