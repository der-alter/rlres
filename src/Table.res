@react.component
let make = (~data, ~moreFunction) => {
  Js.log(data)

  let onClick = e => {
    ReactEvent.Synthetic.preventDefault(e)
    moreFunction()
  }

  <> <Button onClick> {"More"->React.string} </Button> </>
}
