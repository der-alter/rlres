module Styles = {
  open Emotion
  let container = css({
    "display": "flex",
    "flexDirection": "row",
    "justifyContent": "center",
    "alignItems": "center",
    "margin": "4ex auto",
    "maxWidth": "768px",
    "width": "100%",
  })
  let title = css({
    "order": 1,
    "color": "black",
    "fontSize": "1.2em",
    "fontWeight": 500,
    "fontFamily": "monospace",
    "paddingLeft": "2ch",
  })
}

@react.component
let make = (~children) => {
  <header className=Styles.container>
    <h1 className=Styles.title> {"Hackers News Search Engine"->React.string} </h1>
    children
  </header>
}
