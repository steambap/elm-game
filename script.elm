import Html exposing (Html, button, div, text, p, br)
import Html.Events exposing (onClick)
import Time exposing (Time, second)

main =
  Html.program {init = init, view = view, update = update, subscriptions = subscriptions}

-- MODEL
type alias Model = 
  { money: Int,
    slaves: Int,
    workLevel: Int
  }
init: (Model, Cmd Msg)
init =
  ({money = 0, slaves = 1, workLevel = 1}, Cmd.none)

-- HELPER
getSlaveCost: Int -> Int
getSlaveCost slaveNum =
  slaveNum * 5

getWorkUpgradeCost: Int -> Int
getWorkUpgradeCost workLevel =
  workLevel * 300

getIncome: Int -> Int
getIncome slaveNum = 
  slaveNum * 3

-- UPDATE
type Msg = BuySlave | WorkForSelf | Tick Time

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    BuySlave ->
      let
        slaveCost = getSlaveCost(model.slaves)
      in
      if model.money >= slaveCost
      then
      (
        { model |
          money = model.money - model.slaves * 5,
          slaves = model.slaves + 1},
        Cmd.none
      )
      else
        (model, Cmd.none)
    WorkForSelf ->
      (
        { model | money = model.money + model.workLevel * 5 },
        Cmd.none
      )

    Tick _ ->
      (
        { model | money = model.money + model.slaves * 3},
        Cmd.none
      )

-- SUBSCRIPTIONS
subscriptions: Model -> Sub Msg
subscriptions model =
  Time.every second Tick

-- VIEW
view: Model -> Html Msg
view model =
  div []
    [ div [] [text("Money: " ++ toString model.money)]
    , p [] [text("Income: " ++ toString (getIncome model.slaves))]
    , p [] [text("Slaves: " ++ toString model.slaves)]
    , p [] [text("Worker Level: " ++ toString model.workLevel)]
    , br [] []
    , button [onClick WorkForSelf] [text "Work For Yourself"]
    , br [] []
    , button [onClick BuySlave] [text "Buy Slave"]
    ]
