module LoadingState exposing
    ( LoadingState(..)
    , map, toMaybe, fromMaybe, fromResult, withDefault
    )

{-| Track the loading state of an external resource. Ideal for network requests.


# Types

@docs LoadingState


# Functions

@docs map, toMaybe, fromMaybe, fromResult, withDefault

-}


{-| Represents a loading state.
-}
type LoadingState err a
    = NotLoading
    | Loading
    | Loaded a
    | Failed err


{-| Enables working with loaded data.
-}
map : LoadingState err a -> (a -> a) -> LoadingState err a
map loadingState f =
    case unwrap loadingState of
        Just ls ->
            Loaded <| f ls

        Nothing ->
            loadingState


{-| Unwraps a loaded value to a Maybe.
-}
toMaybe : LoadingState err a -> Maybe a
toMaybe loadingState =
    case loadingState of
        Loaded a ->
            Just a

        _ ->
            Nothing


{-| Converts a Maybe to a loaded value.
-}
fromMaybe : Maybe a -> LoadingState err a
fromMaybe maybeA =
    case maybeA of
        Just a ->
            Loaded a

        Nothing ->
            NotLoading


{-| Converts a result to a loading state.
-}
fromResult : Result err a -> LoadingState err a
fromResult result =
    case result of
        Ok a ->
            Loaded a

        Err err ->
            Failed err


{-| If the provided loading state is unsuccessful, return a provided default value.
-}
withDefault : LoadingState err a -> a
withDefault loadingState default =
    case loadingState of
        Loaded a ->
            a

        _ ->
            default
