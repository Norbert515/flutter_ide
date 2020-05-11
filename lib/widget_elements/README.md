
# YAML Schema definition


widgets:
    WidgetName:
        meta:
            display: WidgetToDisplayInDialog
            icon: IconToDisplay
        simpleProperty: DataType
        complexProperty:
            type: String
            default: \Some Default Text Value
            positional: true
            otherPropertyPassedToCustomProperty: 42



widgets:
    WidgetName:
        meta:
            display: WidgetToDisplayInDialog
            icon: IconToDisplay
        general:
            layout:
                slots:
                    - body
                    - appBar
                    - floatingActionButton
                    - slot:
                        name: children
                        type: list
        props:
            simpleProperty: DataType
            complexProperty:
                type: String
                default: \Some Default Text Value
                positional: true
                otherPropertyPassedToCustomProperty: 42



## Layout models

layout: none # Default
layout: single
layout: list
layout:
    slots:
        - body
        - appBar