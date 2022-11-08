
const initialState = {
  savedEvents: []
}

const store = Redux.createStore(
  reducer, 
  initialState, 
  window.__REDUX_DEVTOOLS_EXTENSION__?.()
)