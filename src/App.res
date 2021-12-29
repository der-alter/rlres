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

module App = {
  @react.component
  let make = () => {
    /* let (query, setQuery) = React.useState(_ => QueryConst.defaultQuery) */

    <>
      <Head
        defaultTitle="HN Search Engine" titleTemplate="%s - HN Search Engine"
      />
      <Header>
        <Search>{"Search"->React.string}</Search>
      </Header>
    </>
  }
}

switch ReactDOM.querySelector("#root") {
| Some(root) => ReactDOM.render(<App />, root)
| None => Console.error("Missing #root element")
}
