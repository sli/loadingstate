module LoadingState exposing
    ( LoadingState(..)
    , unwrap, map
    )

{-| Track the loading state of an external resource. Ideal for network requests.


# Types

@docs LoadingState


# Functions

@docs unwrap, map

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


{-| Unwraps a loaded value. Not recommended.
-}
unwrap : LoadingState err a -> Maybe a
unwrap loadingState =
    case loadingState of
        Loaded a ->
            Just a

        _ ->
            Nothing
