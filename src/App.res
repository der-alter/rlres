Emotion.injectGlobal(`
html {
  padding: 0;
  margin: 0;
  height: -webkit-fill-available;
  font-family: sans-serif;
  box-sizing: border-box;
}
body {
  padding: 0; 
  margin: 0;
  color: dimgray;
  background-color:lemonchiffon;
}
#root {
}`)

type state = {
  query: string,
  page: int,
}

let initialState = {
  query: "rescript",
  page: 0,
}

let noHits: array<HN.Hit.t> = []

type action = Query(string) | More

let reducer = (state, action) =>
  switch action {
  | Query(newQuery) => {query: newQuery, page: 0}
  | More => {...state, page: state.page + 1}
  }

module App = {
  @react.component
  let make = () => {
    let (state, dispatch) = React.useReducer(reducer, initialState)
    let (results, setResults) = React.useState(_ => AsyncData.NotAsked)
    let (hits, setHits) = React.useState(_ => noHits)

    React.useEffect1(() => {
      setResults(_ => Loading)
      let request = Request.make(
        ~url=`https://hn.algolia.com/api/v1/search?query=${state.query}&page=${string_of_int(
            state.page,
          )}&hitsPerPage=100`,
        ~responseType=Json,
        (),
      )
      request->Future.get(payload => {
        switch payload {
        | Ok({response}) =>
          setHits(_ =>
            state.page === 0
              ? HN.Hit.parseHits(response)
              : Array.concat(hits, HN.Hit.parseHits(response))
          )
        | _ => ()
        }
        setResults(_ => Done(payload))
      })
      Some(() => request->Future.cancel)
    }, [state])

    <>
      <Head defaultTitle="HN Search Engine" titleTemplate="%s - HN Search Engine" />
      <Header>
        <Search defaultValue=initialState.query submitFunction={v => dispatch(Query(v))}>
          {"Search"->React.string}
        </Search>
      </Header>
      {switch results {
      | NotAsked => React.null
      | Loading => <LoadingIndicator />
      | Done(Error(error)) => <RequestErrorIndicator error />
      | Done(Ok(_)) => <>
          <Table hits />
          <Spacer />
          <Button onClick={_ => dispatch(More)}> {"More"->React.string} </Button>
        </>
      }}
    </>
  }
}

switch ReactDOM.querySelector("#root") {
| Some(root) => ReactDOM.render(<App />, root)
| None => Console.error("Missing #root element")
}
