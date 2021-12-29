module Styles = {
  open Emotion
  let container = css({
    "flexGrow": 0,
    "padding": 10,
  })
  let title = css({
    "textAlign": "center",
    "margin": 0,
    "fontSize": 24,
  })
  let nav = css({
    "display": "flex",
    "flexDirection": "row",
    "alignItems": "stretch",
    "justifyContent": "center",
    "padding": 10,
  })
}

@react.component
let make = () => {
  <header className=Styles.container>
    <h1 className=Styles.title> {"ReScript React Starter Kit"->React.string} </h1>
    <nav className=Styles.nav>
    </nav>
  </header>
}
