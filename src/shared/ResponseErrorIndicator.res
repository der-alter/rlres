module Styles = {
  open Emotion
  let error = css({
    "color": "red",
    "fontSize": "bold",
    "textAlign": "center",
    "padding": "4ex 0",
  })
}

@react.component
let make = (~status: int) => {
  <p className={Styles.error}> {string_of_int(status)->React.string} </p>
}
