module Styles = {
  open Emotion
  let error = css({
    "color": "indianred",
    "fontSize": "bold",
    "textAlign": "center",
    "padding": "4ex 0",
  })
}

@react.component
let make = (~message: string) => {
  <p className={Styles.error}> {message->React.string} </p>
}
