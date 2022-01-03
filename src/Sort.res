module Styles = {
  open Emotion

  let button = css({
    "width": "100%",
    "cursor": "pointer",
    "textAlign": "left",
    "padding": "1ex 2ch",
    "color": "text",
    "background": "lemonchiffon",
    "borderWidth": "0 0 4px",
    "borderStyle": "solid",
    "borderColor": "rgb(255,216,169)",
    "&:hover": {
      "background": "ivory",
      "borderColor": "darkorange",
    },
    "&:focus": {
      "background": "ivory",
      "borderColor": "darkorange",
    },
    "&:active": {
      "background": "ivory",
      "borderColor": "darkorange",
    },
  })

  let activeButton = cx([
    button,
    css({
      "background": "ivory",
      "borderColor": "darkorange",
    }),
  ])
}

@react.component
let make = (~children, ~onSort, ~sortKey, ~activeSortKey) => {
  <button
    className={Some(sortKey) !== activeSortKey ? Styles.button : Styles.activeButton}
    onClick={_ => onSort(sortKey)}>
    children
  </button>
}
