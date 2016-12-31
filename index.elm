import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)

main =
  Html.beginnerProgram {model = model, view = view, update = update}

-- MODEL
type alias Model = 
  { money: Int
  }
model: Model
model =
  {money = 0}

-- UPDATE
type Msg = WorkForSelf

update: Msg -> Model -> Model
update msg model =
  case msg of
    WorkForSelf ->
      { model | money = model.money + 30 }

-- VIEW
view: Model -> Html Msg
view model =
  div []
    [ div [] [text(toString model.money)]
    , button [onClick WorkForSelf] [text "Work For Yourself"]
    ]
