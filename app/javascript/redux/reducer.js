function reducer(state, action) {
  const {type, payload} = action;
  const newState = {...state};

  switch(type) {
    case loadEvents:
      newState.savedEvents = payload
      break
    case removeEvent:
      console.log('removing event')  
      const index = newState.savedEvents.findIndex(event => {
        return event['id'] == payload
      });
      newState.savedEvents.splice(index, 1)
      break;
    case addEvent:
      console.log('adding event')
      newState.savedEvents.push(payload)
      break
    default:
      return state;
  }

  return newState;
}