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

type action = Query(string)

let reducer = (state, action) =>
  switch action {
  | Query(newQuery) => {...state, query: newQuery}
  }

let fetchResults = (~url) => Request.make(~url, ~responseType=Json, ())

module App = {
  @react.component
  let make = () => {
    let (state, dispatch) = React.useReducer(reducer, initialState)
    let (results, setResults) = React.useState(_ => AsyncData.NotAsked)

    React.useEffect1(() => {
      setResults(_ => Loading)
      let request = fetchResults(
        ~url=`https://hn.algolia.com/api/v1/search?query=${state.query}&page=${string_of_int(
            state.page,
          )}&hitsPerPage=100`,
      )
      request->Future.get(payload => setResults(_ => Done(payload)))
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
      | Done(Error(error)) => <ErrorIndicator error />
      | Done(Ok(data)) => <Table data />
      }}
    </>
  }
}

switch ReactDOM.querySelector("#root") {
| Some(root) => ReactDOM.render(<App />, root)
| None => Console.error("Missing #root element")
}
