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

  let container = css({
    "maxWidth": "768px",
    "width": "100%",
    "margin": "4ex auto",
    "display": "flex",
    "flexFlow": "column nowrap",
    "flex": "1 1 auto",
  })

  /* Rows */
  let row = css({
    "width": "100%",
    "display": "flex",
    "flexFlow": "row nowrap",
  })

  let head = cx([row])

  let body = cx([
    row,
    css({
      "width": "100%",
      "display": "flex",
      "flexFlow": "row nowrap",
      "fontSize": ".8em",
    }),
  ])

  /* Cells */
  let cell = css({
    "display": "flex",
    "flexFlow": "row nowrap",
    "flexGrow": 1,
    "lineHeight": "3ex",
    "flexBasis": 0,
  })

  let header = cx([
    cell,
    css({
      "whiteSpace": "normal",
      "justifyContent": "center",
    }),
  ])

  let data = cx([
    cell,
    css({
      "overflow": "hidden",
      "textOverflow": "ellipsis",
      "wordBreak": "break-word",
      "whiteSpace": "nowrap",
    }),
  ])

  let link = css({
    "color": "royalblue",
    "fontWeight": 600,
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

  <section className={Styles.container}>
    <header className={Styles.head}>
      <div className={Styles.header} style={ReactDOM.Style.make(~flexGrow="10", ())}>
        <Sort
          sortKey="TITLE" onSort={_ => dispatch(Sort("TITLE"))} activeSortKey=state.activeSortKey>
          {"Title"->React.string}
        </Sort>
      </div>
      <div className={Styles.header} style={ReactDOM.Style.make(~flexGrow="2", ())}>
        <Sort
          sortKey="AUTHOR" onSort={_ => dispatch(Sort("AUTHOR"))} activeSortKey=state.activeSortKey>
          {"Author"->React.string}
        </Sort>
      </div>
      <div className={Styles.header}>
        <Sort
          sortKey="COMMENTS"
          onSort={_ => dispatch(Sort("COMMENTS"))}
          activeSortKey=state.activeSortKey>
          {"Coms"->React.string}
        </Sort>
      </div>
      <div className={Styles.header}>
        <Sort
          sortKey="POINTS" onSort={_ => dispatch(Sort("POINTS"))} activeSortKey=state.activeSortKey>
          {"Pts"->React.string}
        </Sort>
      </div>
      <div className={Styles.header} style={ReactDOM.Style.make(~flexGrow="2", ())}>
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
        <div className={Styles.body} key=hit.objectId>
          <div className={Styles.data} style={ReactDOM.Style.make(~flexGrow="10", ())}>
            <a
              href={`https://news.ycombinator.com/item?id=${hit.objectId}`}
              className={Styles.link}
              target="_blank"
              rel="noopener noreferrer">
              {Option.getWithDefault(
                hit.title,
                Js.String.substring(
                  ~from=0,
                  ~to_=70,
                  Option.getWithDefault(hit.commentText, "No title"),
                ) ++ "...",
              )->React.string}
            </a>
          </div>
          <div className={Styles.data} style={ReactDOM.Style.make(~flexGrow="2", ())}>
            {hit.author->React.string}
          </div>
          <div className={Styles.data}>
            {Int.toString(Option.getWithDefault(hit.numComments, 0))->React.string}
          </div>
          <div className={Styles.data}>
            {Int.toString(Option.getWithDefault(hit.points, 0))->React.string}
          </div>
          <div className={Styles.data} style={ReactDOM.Style.make(~flexGrow="2", ())}>
            {Int.toString(hit.timestamp)->React.string}
          </div>
        </div>
      ),
    )}
  </section>
}
