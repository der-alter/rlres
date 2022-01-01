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
let make = (~error: [#NetworkRequestFailed | #Timeout]) => {
  let message = switch error {
  | #NetworkRequestFailed => "Error: network request failed"->React.string
  | #Timeout => "Error: timeout"->React.string
  }

  <p className={Styles.error}> message </p>
}
