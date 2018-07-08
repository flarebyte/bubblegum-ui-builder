module IdGenerator exposing(..)

import AnyModel exposing (WidgetType, getIdPrefix) 
import Hashids exposing (hashidsSimple, encodeList)

hashids : Hashids.Context
hashids = hashidsSimple "4kThCaqnggqdRjw3d1s1"

{-| create unique id for this document. -}
create: WidgetType -> Int ->  String
create widgetType counter =
   String.join "-" [getIdPrefix widgetType, encodeList hashids [counter]]
 