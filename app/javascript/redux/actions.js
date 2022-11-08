const addEvent = 'ADD_EVENT';
const removeEvent = 'REMOVE_EVENT'
const loadEvents = 'LOAD_EVENTS'

const doLoadSavedEvents = (events) => {
  return {
    type: loadEvents,
    payload: events
  }
}

const doAddEvent = (event) => {
  return {
    type: addEvent,
    payload: event
  }
}

const doRemoveEvent = (event) => {
  return {
    type: removeEvent,
    payload: event
  }
}