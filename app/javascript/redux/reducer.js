function reducer(state, action) {
  const {type, payload} = action;
  const newState = {...state};

  switch(type) {
    case loadEvents:
      newState.savedEvents = payload
      break
    default:
      return state;
  }

  return newState;
}