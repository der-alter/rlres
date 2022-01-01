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
    "maxWidth": "1024px",
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

  let header = cx([cell])

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

type sortKey = Title | Author | Coms | Pts | Date

type state = {
  activeSortKey: sortKey,
  isSortReverse: bool,
}

let initialState = {
  activeSortKey: Title,
  isSortReverse: false,
}

type action = Sort(sortKey)

let reducer = (state, action) =>
  switch action {
  | Sort(sortKey) => {
      activeSortKey: sortKey,
      isSortReverse: state.activeSortKey === sortKey && !state.isSortReverse,
    }
  }

let sorts = (sortKey: sortKey) =>
  switch sortKey {
  | Title => (a: HN.Hit.t, b: HN.Hit.t) => compare(a.title, b.title)
  | Author => (a: HN.Hit.t, b: HN.Hit.t) => compare(a.author, b.author)
  | Coms => (a: HN.Hit.t, b: HN.Hit.t) => compare(a.numComments, b.numComments)
  | Pts => (a: HN.Hit.t, b: HN.Hit.t) => compare(a.points, b.points)
  | Date => (a: HN.Hit.t, b: HN.Hit.t) => compare(a.timestamp, b.timestamp)
  }

@react.component
let make = (~hits: array<HN.Hit.t>) => {
  let (state, dispatch) = React.useReducer(reducer, initialState)
  let sortedList = hits->SortArray.stableSortBy(sorts(state.activeSortKey))
  let reverseSortedList = state.isSortReverse ? sortedList->Array.reverseInPlace : sortedList

  <section className={Styles.container}>
    <header className={Styles.head}>
      <div className={Styles.header} style={ReactDOM.Style.make(~flexGrow="10", ())}>
        <Sort sortKey=Title onSort={_ => dispatch(Sort(Title))} activeSortKey=state.activeSortKey>
          {"Title"->React.string}
        </Sort>
      </div>
      <div className={Styles.header} style={ReactDOM.Style.make(~flexGrow="2", ())}>
        <Sort sortKey=Author onSort={_ => dispatch(Sort(Author))} activeSortKey=state.activeSortKey>
          {"Author"->React.string}
        </Sort>
      </div>
      <div className={Styles.header}>
        <Sort sortKey=Coms onSort={_ => dispatch(Sort(Coms))} activeSortKey=state.activeSortKey>
          {"Coms"->React.string}
        </Sort>
      </div>
      <div className={Styles.header}>
        <Sort sortKey=Pts onSort={_ => dispatch(Sort(Pts))} activeSortKey=state.activeSortKey>
          {"Pts"->React.string}
        </Sort>
      </div>
      <div className={Styles.header} style={ReactDOM.Style.make(~flexGrow="2", ())}>
        <Sort sortKey=Date onSort={_ => dispatch(Sort(Date))} activeSortKey=state.activeSortKey>
          {"Date"->React.string}
        </Sort>
      </div>
    </header>
    {React.array(
      Array.map(reverseSortedList, item =>
        <div className={Styles.body} key=item.objectId>
          <div className={Styles.data} style={ReactDOM.Style.make(~flexGrow="10", ())}>
            <a
              href={`https://news.ycombinator.com/item?id=${item.objectId}`}
              className={Styles.link}
              target="_blank"
              rel="noopener noreferrer">
              {Option.getWithDefault(
                item.title,
                Js.String.substring(
                  ~from=0,
                  ~to_=70,
                  Option.getWithDefault(item.commentText, "No title"),
                ) ++ "...",
              )->React.string}
            </a>
          </div>
          <div className={Styles.data} style={ReactDOM.Style.make(~flexGrow="2", ())}>
            {item.author->React.string}
          </div>
          <div className={Styles.data}>
            {Int.toString(Option.getWithDefault(item.numComments, 0))->React.string}
          </div>
          <div className={Styles.data}>
            {Int.toString(Option.getWithDefault(item.points, 0))->React.string}
          </div>
          <div className={Styles.data} style={ReactDOM.Style.make(~flexGrow="2", ())}>
            {Int.toString(item.timestamp)->React.string}
          </div>
        </div>
      ),
    )}
  </section>
}
