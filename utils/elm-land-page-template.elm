module Pages.Artikkel.Id_ exposing (Model, Msg, page)

import Auth
import Effect exposing (Effect)
import Html
import MainLayout
import Page exposing (Page, init)
import Pages.Components exposing (Model, Msg)
import Pages.Rettskilder exposing (Msg(..))
import PagesComponents.Pro.Static.Update exposing (update)
import PagesComponents.Pro.Static.View exposing (view)
import Route exposing (Route)
import Shared
import Translations.Search
import View exposing (View)


page : Auth.User -> Shared.Model -> Route { id : String } -> Page Model Msg
page user shared route =
    Page.new
        { init = \_ -> init shared route
        , update = update shared route
        , subscriptions = always Sub.none
        , view = view shared route user
        }


init : Shared.Model -> Route params -> ( Model, Effect Msg )
init shared route =
    let
        ( headerModel, headerEffect ) =
            MainLayout.init shared route
    in
    ( { headerModel = headerModel }
    , Effect.map HeaderMsg headerEffect
    )


type alias Model =
    { headerModel : MainLayout.Model }


type Msg
    = -- HEADER
      HeaderMsg MainLayout.Msg
    | Noop


update : Shared.Model -> Route { id : String } -> Msg -> Model -> ( Model, Effect Msg )
update shared route msg model =
    case msg of
        Noop ->
            ( model, Effect.none )

        HeaderMsg childMsg ->
            let
                ( newHeaderModel, headerEffect, _ ) =
                    MainLayout.update shared route childMsg model.headerModel

                newModel =
                    { model | headerModel = newHeaderModel }
            in
            ( newModel
            , Effect.map HeaderMsg headerEffect
            )


view : Shared.Model -> Route { id : String } -> Auth.User -> Model -> View Msg
view shared route _ model =
    MainLayout.view shared
        route
        { toContentMsg = HeaderMsg
        , content =
            { title = Translations.Search.search shared.settings.translations
            , body = [ Html.text route.params.id ]
            }
        , model = model.headerModel
        , maybeGrid = Nothing
        , maybeTopRow = Nothing
        }
