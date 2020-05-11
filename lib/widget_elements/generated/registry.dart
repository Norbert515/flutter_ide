import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:widget_maker_2_0/modules/workspace/workspace_page/bars/palette/palette_bar.dart';
import 'package:widget_maker_2_0/widget_elements/display/display.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/Text.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/AppBar.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/CupertinoNavigationBar.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/Icon.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/Form.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/Material.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/Flexible.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/TextFormField.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/GestureDetector.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/WNetworkImage.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/SizedBox.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/CircularProgressIndicator.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/LinearProgressIndicator.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/CupertinoActivityIndicator.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/FloatingActionButton.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/Scaffold.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/ListTile.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/Center.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/Padding.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/RotatedBox.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/AspectRatio.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/TextField.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/FractionallySizedBox.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/Divider.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/Align.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/UnconstrainedBox.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/ConstrainedBox.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/WContainer.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/AbsorbPointer.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/WCircleAvatar.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/Card.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/Checkbox.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/Chip.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/WPageView.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/Column.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/Row.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/Expanded.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/MaterialButton.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/OutlineButton.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/RaisedButton.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/CupertinoButton.dart';
import 'package:widget_maker_2_0/widget_elements/generated/widgets/WAnimatedContainer.dart';

class R2D2 {

  PaletteItem text = PaletteItem(
    name: "Text",
    icon: Icons.add,
    widget: DText(),
    categories: [
     "None"
    ],
    generator: (id) => TextElement(id: id),
  );
  
  PaletteItem appBar = PaletteItem(
    name: "AppBar",
    icon: Icons.add,
    widget: DAppBar(),
    categories: [
     "App Essentials"
    ],
    generator: (id) => AppBarElement(id: id),
  );
  
  PaletteItem cupertinoNavigationBar = PaletteItem(
    name: "CupertinoNavigationBar",
    icon: Icons.add,
    categories: [
     "None"
    ],
    generator: (id) => CupertinoNavigationBarElement(id: id),
  );
  
  PaletteItem icon = PaletteItem(
    name: "Icon",
    icon: Icons.add,
    categories: [
     "None"
    ],
    generator: (id) => IconElement(id: id),
  );
  
  PaletteItem form = PaletteItem(
    name: "Form",
    icon: Icons.add,
    categories: [
     "None"
    ],
    generator: (id) => FormElement(id: id),
  );
  
  PaletteItem material = PaletteItem(
    name: "Material",
    icon: Icons.add,
    categories: [
     "None"
    ],
    generator: (id) => MaterialElement(id: id),
  );
  
  PaletteItem flexible = PaletteItem(
    name: "Flexible",
    icon: Icons.add,
    categories: [
     "None"
    ],
    generator: (id) => FlexibleElement(id: id),
  );
  
  PaletteItem textFormField = PaletteItem(
    name: "TextFormField",
    icon: Icons.add,
    categories: [
     "None"
    ],
    generator: (id) => TextFormFieldElement(id: id),
  );
  
  PaletteItem gestureDetector = PaletteItem(
    name: "GestureDetector",
    icon: Icons.add,
    categories: [
     "None"
    ],
    generator: (id) => GestureDetectorElement(id: id),
  );
  
  PaletteItem wNetworkImage = PaletteItem(
    name: "NetworkImage",
    icon: Icons.add,
    categories: [
     "None"
    ],
    generator: (id) => WNetworkImageElement(id: id),
  );
  
  PaletteItem sizedBox = PaletteItem(
    name: "SizedBox",
    icon: Icons.add,
    categories: [
     "Layout"
    ],
    generator: (id) => SizedBoxElement(id: id),
  );
  
  PaletteItem circularProgressIndicator = PaletteItem(
    name: "CircularProgressIndicator",
    icon: Icons.add,
    widget: CircularProgressIndicator(),
    categories: [
     "None"
    ],
    generator: (id) => CircularProgressIndicatorElement(id: id),
  );
  
  PaletteItem linearProgressIndicator = PaletteItem(
    name: "LinearProgressIndicator",
    icon: Icons.add,
    widget: LinearProgressIndicator(),
    categories: [
     "None"
    ],
    generator: (id) => LinearProgressIndicatorElement(id: id),
  );
  
  PaletteItem cupertinoActivityIndicator = PaletteItem(
    name: "CupertinoActivityIndicator",
    icon: Icons.add,
    widget: CupertinoActivityIndicator(),
    categories: [
     "None"
    ],
    generator: (id) => CupertinoActivityIndicatorElement(id: id),
  );
  
  PaletteItem floatingActionButton = PaletteItem(
    name: "FloatingActionButton",
    icon: Icons.add,
    widget: DFloatingActionButton(),
    categories: [
     "App Essentials"
    ],
    generator: (id) => FloatingActionButtonElement(id: id),
  );
  
  PaletteItem scaffold = PaletteItem(
    name: "Scaffold",
    icon: Icons.add,
    widget: DScaffold(),
    categories: [
     "Layout",
     "App Essentials"
    ],
    generator: (id) => ScaffoldElement(id: id),
  );
  
  PaletteItem listTile = PaletteItem(
    name: "ListTile",
    icon: Icons.add,
    categories: [
     "App Essentials"
    ],
    generator: (id) => ListTileElement(id: id),
  );
  
  PaletteItem center = PaletteItem(
    name: "Center",
    icon: Icons.add,
    widget: DCenter(),
    categories: [
     "None"
    ],
    generator: (id) => CenterElement(id: id),
  );
  
  PaletteItem padding = PaletteItem(
    name: "Padding",
    icon: Icons.add,
    categories: [
     "Layout"
    ],
    generator: (id) => PaddingElement(id: id),
  );
  
  PaletteItem rotatedBox = PaletteItem(
    name: "RotatedBox",
    icon: Icons.add,
    widget: DRotatedBox(),
    categories: [
     "Child Transformation"
    ],
    generator: (id) => RotatedBoxElement(id: id),
  );
  
  PaletteItem aspectRatio = PaletteItem(
    name: "AspectRatio",
    icon: Icons.add,
    categories: [
     "Child Transformation"
    ],
    generator: (id) => AspectRatioElement(id: id),
  );
  
  PaletteItem textField = PaletteItem(
    name: "TextField",
    icon: Icons.add,
    categories: [
     "None"
    ],
    generator: (id) => TextFieldElement(id: id),
  );
  
  PaletteItem fractionallySizedBox = PaletteItem(
    name: "FractionallySizedBox",
    icon: Icons.add,
    categories: [
     "Child Transformation"
    ],
    generator: (id) => FractionallySizedBoxElement(id: id),
  );
  
  PaletteItem divider = PaletteItem(
    name: "Divider",
    icon: Icons.add,
    categories: [
     "None"
    ],
    generator: (id) => DividerElement(id: id),
  );
  
  PaletteItem align = PaletteItem(
    name: "Align",
    icon: Icons.add,
    categories: [
     "Child Transformation"
    ],
    generator: (id) => AlignElement(id: id),
  );
  
  PaletteItem unconstrainedBox = PaletteItem(
    name: "UnconstrainedBox",
    icon: Icons.add,
    categories: [
     "None"
    ],
    generator: (id) => UnconstrainedBoxElement(id: id),
  );
  
  PaletteItem constrainedBox = PaletteItem(
    name: "ConstrainedBox",
    icon: Icons.add,
    categories: [
     "None"
    ],
    generator: (id) => ConstrainedBoxElement(id: id),
  );
  
  PaletteItem wContainer = PaletteItem(
    name: "Container",
    icon: Icons.add,
    categories: [
     "Layout"
    ],
    generator: (id) => WContainerElement(id: id),
  );
  
  PaletteItem absorbPointer = PaletteItem(
    name: "AbsorbPointer",
    icon: Icons.add,
    categories: [
     "Semantics"
    ],
    generator: (id) => AbsorbPointerElement(id: id),
  );
  
  PaletteItem wCircleAvatar = PaletteItem(
    name: "CircleAvatar",
    icon: Icons.add,
    categories: [
     "None"
    ],
    generator: (id) => WCircleAvatarElement(id: id),
  );
  
  PaletteItem card = PaletteItem(
    name: "Card",
    icon: Icons.add,
    widget: DCard(),
    categories: [
     "None"
    ],
    generator: (id) => CardElement(id: id),
  );
  
  PaletteItem checkbox = PaletteItem(
    name: "Checkbox",
    icon: Icons.add,
    widget: DCheckbox(),
    categories: [
     "None"
    ],
    generator: (id) => CheckboxElement(id: id),
  );
  
  PaletteItem chip = PaletteItem(
    name: "Chip",
    icon: Icons.add,
    categories: [
     "None"
    ],
    generator: (id) => ChipElement(id: id),
  );
  
  PaletteItem wPageView = PaletteItem(
    name: "PageView",
    icon: Icons.add,
    categories: [
     "None"
    ],
    generator: (id) => WPageViewElement(id: id),
  );
  
  PaletteItem column = PaletteItem(
    name: "Column",
    icon: Icons.add,
    widget: DColumn(),
    categories: [
     "None"
    ],
    generator: (id) => ColumnElement(id: id),
  );
  
  PaletteItem row = PaletteItem(
    name: "Row",
    icon: Icons.add,
    widget: DRow(),
    categories: [
     "None"
    ],
    generator: (id) => RowElement(id: id),
  );
  
  PaletteItem expanded = PaletteItem(
    name: "Expanded",
    icon: Icons.add,
    categories: [
     "None"
    ],
    generator: (id) => ExpandedElement(id: id),
  );
  
  PaletteItem materialButton = PaletteItem(
    name: "MaterialButton",
    icon: Icons.add,
    widget: DMaterialButton(),
    categories: [
     "None"
    ],
    generator: (id) => MaterialButtonElement(id: id),
  );
  
  PaletteItem outlineButton = PaletteItem(
    name: "OutlineButton",
    icon: Icons.add,
    widget: DOutlineButton(),
    categories: [
     "None"
    ],
    generator: (id) => OutlineButtonElement(id: id),
  );
  
  PaletteItem raisedButton = PaletteItem(
    name: "RaisedButton",
    icon: Icons.add,
    widget: DRaisedButton(),
    categories: [
     "None"
    ],
    generator: (id) => RaisedButtonElement(id: id),
  );
  
  PaletteItem cupertinoButton = PaletteItem(
    name: "CupertinoButton",
    icon: Icons.add,
    widget: DCupertinoButton(),
    categories: [
     "None"
    ],
    generator: (id) => CupertinoButtonElement(id: id),
  );
  
  PaletteItem wAnimatedContainer = PaletteItem(
    name: "AnimatedContainer",
    icon: Icons.add,
    categories: [
     "Layout"
    ],
    generator: (id) => WAnimatedContainerElement(id: id),
  );
  


  List<PaletteItem> get allItems => [
    text,
    appBar,
    cupertinoNavigationBar,
    icon,
    form,
    material,
    flexible,
    textFormField,
    gestureDetector,
    wNetworkImage,
    sizedBox,
    circularProgressIndicator,
    linearProgressIndicator,
    cupertinoActivityIndicator,
    floatingActionButton,
    scaffold,
    listTile,
    center,
    padding,
    rotatedBox,
    aspectRatio,
    textField,
    fractionallySizedBox,
    divider,
    align,
    unconstrainedBox,
    constrainedBox,
    wContainer,
    absorbPointer,
    wCircleAvatar,
    card,
    checkbox,
    chip,
    wPageView,
    column,
    row,
    expanded,
    materialButton,
    outlineButton,
    raisedButton,
    cupertinoButton,
    wAnimatedContainer
  ];
  
  
  Map<String, List<PaletteItem>> get categories => {
    "None": [
       text,
       cupertinoNavigationBar,
       icon,
       form,
       material,
       flexible,
       textFormField,
       gestureDetector,
       wNetworkImage,
       circularProgressIndicator,
       linearProgressIndicator,
       cupertinoActivityIndicator,
       center,
       textField,
       divider,
       unconstrainedBox,
       constrainedBox,
       wCircleAvatar,
       card,
       checkbox,
       chip,
       wPageView,
       column,
       row,
       expanded,
       materialButton,
       outlineButton,
       raisedButton,
       cupertinoButton
    ],
        "App Essentials": [
       appBar,
       floatingActionButton,
       scaffold,
       listTile
    ],
        "Layout": [
       sizedBox,
       scaffold,
       padding,
       wContainer,
       wAnimatedContainer
    ],
        "Child Transformation": [
       rotatedBox,
       aspectRatio,
       fractionallySizedBox,
       align
    ],
        "Semantics": [
       absorbPointer
    ],
    
  };
  
}
  