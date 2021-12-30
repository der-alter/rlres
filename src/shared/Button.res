module Styles = {
  open Emotion
  let button = css({
    "outline": "none",
    "cursor": "pointer",
    "color": "white",
    "fontWeight": "bold",
    "background": "darkorange",
    "borderWidth": "0 0 4px",
    "borderStyle": "solid",
    "borderColor": "rgb(204, 112, 0)",
    "borderRadius": 4,
    "padding": "1ex 2ch",
    "&:hover": {
      "background": "rgb(255, 163, 51)",
      "borderColor": "darkorange",
    },
    "&:focus": {
      "background": "rgb(255, 163, 51)",
      "borderColor": "darkorange",
    },
    "&:active": {
      "background": "rgb(255, 163, 51)",
      "borderColor": "darkorange",
    },
  })
}

@react.component
let make = (~children, ~onClick=?) => {
  switch onClick {
  | Some(onClick) => <button className={Styles.button} onClick> children </button>
  | None => <button className={Styles.button}> children </button>
  }
}
