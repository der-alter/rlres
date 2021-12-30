open ReactTest

testWithReact("Header renders", container => {
  act(() => ReactDOM.render(<Header>{"Ok Child"->React.string}</Header>, container))

  Assert.elementContains(~message="Renders title", container, "Hackers News Search Engine")
  Assert.elementContains(~message="Renders child", container, "Ok Child")
})
