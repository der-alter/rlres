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

let fetchResults = (~url) => Request.make(~url, ~responseType=Json, ())

module App = {
  @react.component
  let make = () => {
    let (query, setQuery) = React.useState(_ => QueryConst.defaultQuery)
    let (results, setResults) = React.useState(_ => AsyncData.NotAsked)
    let page = 0

    React.useEffect1(() => {
      setResults(_ => Loading)
      let request = fetchResults(
        ~url=`https://hn.algolia.com/api/v1/search?query=${query}&page=${string_of_int(
            page + 1,
          )}&hitsPerPage=${QueryConst.defaultHPP}`,
      )
      request->Future.get(payload => setResults(_ => Done(payload)))
      Some(() => request->Future.cancel)
    }, [query])

    <>
      <Head defaultTitle="HN Search Engine" titleTemplate="%s - HN Search Engine" />
      <Header> <Search> {"Search"->React.string} </Search> </Header>
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
