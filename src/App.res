Emotion.injectGlobal(`
html {
  padding: 0;
  margin: 0;
  height: -webkit-fill-available;
  font-family: sans-serif;
}
body {
  padding: 0; 
  margin: 0;
  display: flex;
  flex-direction: column;
  min-height: 100vh;
  min-height: -webkit-fill-available;
}
#root {
  display: flex;
  flex-direction: column;
  flex-grow: 1
}`)


module App = {
  @react.component
  let make = () => {
    <>
      <Head
        defaultTitle="HN Search Engine" titleTemplate="%s - HN Search Engine"
      />
      <Header />
      <Footer />
    </>
  }
}

switch ReactDOM.querySelector("#root") {
| Some(root) => ReactDOM.render(<App />, root)
| None => Console.error("Missing #root element")
}
