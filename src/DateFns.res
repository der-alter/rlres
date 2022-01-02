type formatDistanceOptions = {addSuffix: bool}
let formatDistanceOptions = {
  addSuffix: true,
}

@module("date-fns")
external formatDistance: (Js.Date.t, Js.Date.t, 'a) => string = "formatDistance"
