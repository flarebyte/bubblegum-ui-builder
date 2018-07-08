module AnyModel exposing(..)

import Set exposing (Set)

type WidgetType =
    CheckboxWidget
    | IncSpinnerWidget
    | MediumTextWidget
    | BoundedListBoxWidget
    | BoundedMultipleSelectWidget
    | UnboundedListBoxWidget
    | RangeSliderWidget
    | DateViewerWidget
    | LongTextWidget
    | TextAreaWidget
    | BoundedRadioWidget
    | RowPanelWidget
    | BlockWidget
    | DocumentWidget

type SomeFieldModel =
    HelpInvalid String
    | HelpValid String
    | Hint String
    | Icons (Set String)
    | Label String
    | LanguageSyntax String
    | MaxItems Int       
    | MaxLength Int       
    | MaxLines Int       
    | MinItems Int       
    | MinLines Int       
    | Placeholder String   
    | Position Int
    | RegularExpr String
    | Styles (Set String)
    | Traits (Set String)
    | Validator String

type FieldType =
    HelpInvalidType
    | HelpValidType
    | HintType
    | IconsType
    | LabelType
    | LanguageSyntaxType
    | MaxItemsType    
    | MaxLengthType  
    | MaxLinesType     
    | MinItemsType     
    | MinLinesType    
    | PlaceholderType  
    | PositionType
    | RegularExprType
    | StylesType
    | TraitsType
    | ValidatorType

type FieldInfoType = UrlText | CurieText | LabelText | MultilineText | EnumText | TagSet | NumberText

type alias FieldInfo = {
    label: String
    , hint: String
    , infoType: FieldInfoType
    , suggestions: List String
}

type alias AnyModel = {
    id: String
    , widgetType: WidgetType
    , fields: List SomeFieldModel
}


createField: FieldType -> SomeFieldModel
createField fieldType =
    case fieldType of
        HelpInvalidType ->
            HelpInvalid ""
        HelpValidType ->
            HelpValid ""
        HintType ->
            Hint ""
        IconsType ->
            Icons Set.empty
        LabelType ->
            Label ""
        LanguageSyntaxType ->
            LanguageSyntax ""
        MaxItemsType ->
            MaxItems 1000
        MaxLengthType ->
            MaxLength 1000
        MaxLinesType ->
            MaxLines 1000
        MinItemsType ->
            MinItems 0
        MinLinesType ->
            MinLines 0
        RegularExprType ->
            RegularExpr ""
        PositionType ->
            Position 0
        PlaceholderType ->
            Placeholder ""
        StylesType ->
            Styles Set.empty
        TraitsType ->
            Traits Set.empty
        ValidatorType ->
            Validator ""

getFieldInfo: FieldType -> FieldInfo
getFieldInfo fieldType =
    case fieldType of
        HelpInvalidType -> 
            { label = "Help Invalid"
            , hint = "Help Invalid"
            , infoType = LabelText
            , suggestions = []
            }
        HelpValidType ->
            { label = "Help Valid"
            , hint = "Help Valid"
            , infoType = LabelText
            , suggestions = []
            }
        HintType ->
            { label = "Hint"
            , hint = "Practical information that could be helpful"
            , infoType = LabelText
            , suggestions = []
            }
        IconsType ->
            { label = "Icons"
            , hint = "A list of icons to display"
            , infoType = LabelText
            , suggestions = []
            }
        LabelType ->
            { label = "Label"
            , hint = "The main caption for the field"
            , infoType = LabelText
            , suggestions = []
            }
        LanguageSyntaxType ->
            { label = "Language syntax"
            , hint = "The format supported by the field"
            , infoType = LabelText
            , suggestions = []
            }
        MaxItemsType ->
            { label = "Maximum number of items"
            , hint = "The maximum number of items for this entity"
            , infoType = NumberText
            , suggestions = []
            }
        MaxLengthType ->
            { label = "Maximum length"
            , hint = "The maximum number of characters for this field"
            , infoType = NumberText
            , suggestions = []
            }
        MaxLinesType ->
            { label = "Maximum number of lines"
            , hint = "The maximum number of lines for this text area"
            , infoType = NumberText
            , suggestions = []
            }
        MinItemsType ->
            { label = "Minimum number of items"
            , hint = "The minimum number of items for this entity"
            , infoType = NumberText
            , suggestions = []
            }
        MinLinesType ->
            { label = "Minimum number of lines"
            , hint = "The minimum number of lines for this text area"
            , infoType = NumberText
            , suggestions = []
            }
        RegularExprType ->
            { label = "Regex"
            , hint = "A regular expression for this field"
            , infoType = LabelText
            , suggestions = []
            }
        PositionType ->
            { label = "Position"
            , hint = "the position or rank of this field compared to other fields"
            , infoType = LabelText
            , suggestions = []
            }
        PlaceholderType ->
            { label = "Placeholder"
            , hint = "A placeholder to be displayed inside a field"
            , infoType = LabelText
            , suggestions = []
            }
        StylesType ->
            { label = "Styles"
            , hint = "A list of css styles to be applied to the widget or field"
            , infoType = TagSet
            , suggestions = ["red", "blue", "pink"]
            }
        TraitsType ->
             { label = "Traits"
            , hint = "A list of unique traits for this field"
            , infoType = EnumText
            , suggestions = ["alpha", "beta", "delta"]
            }
        ValidatorType ->
            { label = "Validator"
            , hint = "A validation function to apply to the field"
            , infoType = LabelText
            , suggestions = []
            }

basicFieldSupport : List FieldType
basicFieldSupport = [LabelType, HintType, HelpInvalidType, HelpValidType,  MinItemsType, MaxItemsType, TraitsType, StylesType, PositionType]
other = [IconsType, LanguageSyntaxType, MaxLengthType, MaxLinesType, MinLinesType, PlaceholderType, RegularExprType, ValidatorType]
documentFieldSupport: List FieldType
documentFieldSupport = []

getSupportedFieldTypes: WidgetType -> List FieldType
getSupportedFieldTypes widgetType =
    case widgetType of
        CheckboxWidget ->
            basicFieldSupport
        IncSpinnerWidget ->
            basicFieldSupport
        MediumTextWidget ->
            basicFieldSupport
        BoundedListBoxWidget ->
            basicFieldSupport
        BoundedMultipleSelectWidget ->
            basicFieldSupport
        UnboundedListBoxWidget ->
            basicFieldSupport
        RangeSliderWidget ->
            basicFieldSupport
        DateViewerWidget ->
            basicFieldSupport
        LongTextWidget ->
            basicFieldSupport
        TextAreaWidget ->
            basicFieldSupport
        BoundedRadioWidget ->
            basicFieldSupport
        RowPanelWidget ->
            basicFieldSupport
        BlockWidget ->
            basicFieldSupport
        DocumentWidget ->
            documentFieldSupport
   
getIdPrefix: WidgetType -> String
getIdPrefix widgetType =
    case widgetType of
        CheckboxWidget ->
            "checkbox-widget"
        IncSpinnerWidget ->
            "inc-spinner-widget"
        MediumTextWidget ->
            "medium-text-widget"
        BoundedListBoxWidget ->
            "bounded-list-box-widget"
        BoundedMultipleSelectWidget ->
            "bounded-multiple-select-widget"
        UnboundedListBoxWidget ->
            "unbounded-list-box-widget"
        RangeSliderWidget ->
            "range-slider-widget"
        DateViewerWidget ->
            "date-viewer-widget"
        LongTextWidget ->
            "long-text-widget"
        TextAreaWidget ->
            "text-area-widget"
        BoundedRadioWidget ->
            "bounded-radio-widget"
        RowPanelWidget ->
            "row-panel-widget"
        BlockWidget ->
            "block-widget"
        DocumentWidget ->
            "document-widget"

createAnyModel: String -> WidgetType -> AnyModel
createAnyModel id widgetType =
    {
    id = id
    , widgetType = widgetType
    , fields = getSupportedFieldTypes widgetType |> List.map createField
    }
