module Styles = {
  open Emotion
  let container = css({
    "display": "flex",
    "flexGrow": 1,
  })
  let input = css({
    "flexGrow": 1,
    "margin": "0 1ch",
    "border": "0px solid",
    "border-radius": "4px",
    "background": "ivory",
    "margin-left": "6ch",
    "height": "6ex",
    "padding": "1ch 2ex",
  })
}

@react.component
let make = (~children) => {
  <form className=Styles.container>
    <SVGIconSearch style={ReactDOM.Style.make(~overflow="visible", ~display="block", ())} fill="darkorange" height="15" width="15" />
    <input className={Styles.input} />
    <Button>
      children
    </Button>
  </form>
}
