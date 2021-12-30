@react.component
let make = (~error: [#NetworkRequestFailed | #Timeout]) => {
  <p>{"NOk"->React.string}</p>
}
