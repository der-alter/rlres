module Styles = {
  open Emotion
  let container = css({
    "display": "flex",
    "margin": "4ex auto",
    "maxWidth": "768px",
    "width": "100%",
    "flexDirection": "row",
    "justifyContent": "center",
    "alignItems": "center",
    "marginBottom": "5ex",
  })
  let title = css({
    "order": 1,
    "color": "black",
    "fontSize": "1.2em",
    "fontWeight": 500,
    "paddingLeft": "2ch",
  })
}

@react.component
let make = (~children) => {
  <header className=Styles.container>
    <h1 className=Styles.title> {"Hackers News Search Engine"->React.string} </h1> children
  </header>
}
