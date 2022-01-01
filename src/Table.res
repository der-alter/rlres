module Sort = {
  module Styles = {
    open Emotion

    let button = css({
      "width": "100%",
      "cursor": "pointer",
      "textAlign": "left",
      "padding": "1ex 2ch",
      "color": "text",
      "background": "lemonchiffon",
      "borderWidth": "0 0 4px",
      "borderStyle": "solid",
      "borderColor": "rgb(255,216,169)",
      "&:hover": {
        "background": "ivory",
        "borderColor": "darkorange",
      },
      "&:focus": {
        "background": "ivory",
        "borderColor": "darkorange",
      },
      "&:active": {
        "background": "ivory",
        "borderColor": "darkorange",
      },
    })

    let activeButton = cx([
      button,
      css({
        "background": "ivory",
        "borderColor": "darkorange",
      }),
    ])
  }

  @react.component
  let make = (~children, ~onSort, ~sortKey, ~activeSortKey) => {
    <button
      className={sortKey !== activeSortKey ? Styles.button : Styles.activeButton}
      onClick={_ => onSort(sortKey)}>
      children
    </button>
  }
}

module Styles = {
  open Emotion

  let header = css({
    "display": "flex",
  })
}

type state = {
  activeSortKey: string,
  isSortReverse: bool,
}

let initialState = {
  activeSortKey: "TITLE",
  isSortReverse: false,
}

type action = Sort(string)

let reducer = (state, action) =>
  switch action {
  | Sort(sortKey) => {...state, activeSortKey: sortKey}
  }

@react.component
let make = (~hits: array<HN.Hit.t>) => {
  let (state, dispatch) = React.useReducer(reducer, initialState)
  Js.log(hits)

  <section>
    <header className={Styles.header}>
      <div style={ReactDOM.Style.make(~flexGrow="16", ())}>
        <Sort
          sortKey="TITLE" onSort={_ => dispatch(Sort("TITLE"))} activeSortKey=state.activeSortKey>
          {"Title"->React.string}
        </Sort>
      </div>
      <div style={ReactDOM.Style.make(~flexGrow="3", ())}>
        <Sort
          sortKey="AUTHOR" onSort={_ => dispatch(Sort("AUTHOR"))} activeSortKey=state.activeSortKey>
          {"Author"->React.string}
        </Sort>
      </div>
      <div style={ReactDOM.Style.make(~flexGrow="1", ())}>
        <Sort
          sortKey="COMMENTS"
          onSort={_ => dispatch(Sort("COMMENTS"))}
          activeSortKey=state.activeSortKey>
          {"Coms"->React.string}
        </Sort>
      </div>
      <div style={ReactDOM.Style.make(~flexGrow="1", ())}>
        <Sort
          sortKey="POINTS" onSort={_ => dispatch(Sort("POINTS"))} activeSortKey=state.activeSortKey>
          {"Pts"->React.string}
        </Sort>
      </div>
      <div style={ReactDOM.Style.make(~flexGrow="1", ())}>
        <Sort
          sortKey="CREATEDAT"
          onSort={_ => dispatch(Sort("CREATEDAT"))}
          activeSortKey=state.activeSortKey>
          {"Date"->React.string}
        </Sort>
      </div>
    </header>
    {React.array(
      Array.map(hits, hit =>
        <div key=hit.objectId>
          <div>
            {Option.getWithDefault(
              hit.title,
              Js.String.substring(
                ~from=0,
                ~to_=70,
                Option.getWithDefault(hit.commentText, "No title"),
              ),
            )->React.string}
          </div>
        </div>
      ),
    )}
  </section>
}
