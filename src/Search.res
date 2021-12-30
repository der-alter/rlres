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
    "borderRadius": "4px",
    "background": "ivory",
    "marginLeft": "6ch",
    "height": "6ex",
    "padding": "1ch 2ex",
  })
}

@react.component
let make = (~children, ~defaultValue: string, ~submitFunction: 'a => unit) => {
  let (q, setQ) = React.useState(_ => defaultValue)

  let onChange = e => {
    let value = ReactEvent.Form.target(e)["value"]
    switch value {
    | Some(v) => setQ(v)
    | None => ()
    }
  }

  let onSubmit = e => {
    ReactEvent.Synthetic.preventDefault(e)
    submitFunction(q)
  }

  <form className=Styles.container onSubmit>
    <SVGIconSearch
      style={ReactDOM.Style.make(~overflow="visible", ~display="block", ())}
      fill="darkorange"
      height="15"
      width="15"
    />
    <input className={Styles.input} defaultValue onChange />
    <Button> children </Button>
  </form>
}
