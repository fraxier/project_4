$(document).ready(async function() {
  const events = await reduxPage();
  store.dispatch(doLoadSavedEvents(events));

  populateUI();

  $('.card-heart').click(handleHeartClick);

  function handleHeartClick() {
    $(this).off('click', handleHeartClick);

    // if already saved then remove else add to saved_events cookie + add to offcanvas
    const id = $(this).data('id');

    const events = store.getState().savedEvents

    if (events.find(event => event.id === id)) {
      fetch(`/remove_event/${id}`, { method: 'POST' })
      .then(() => {
        $(this).text('🤍')
        removeFromOffCanvas(id)
      })
      .catch(error => console.log(error))
    } else {
      fetch(`/save_event/${id}`, { method: 'POST' })
      .then(() => {
        $(this).text('❤️')
        addToOffCanvas(id, $(this))
      })
      .catch(error => console.log(error))
    }

    $(this).on('click', handleHeartClick);
  }

  function addToOffCanvas(id, element) {
    // console.log('adding to canvas', id, element.data('name'), element.data('date'))
    $('#eventsList').append(`
      <li id='event-id-${id}'>
        ${element.data('name')}
        <span class="badge rounded-pill text-bg-primary">${element.data('date')}</span>
      </li>`
    );
  }

  function removeFromOffCanvas(id) {
    $(`#event-id-${id}`).remove()
  }
    
  function populateUI() {
    $('.card-heart').each(function() {
      const events = store.getState().savedEvents
      

      if (typeof events[Symbol.iterator] === 'function') {
        for (const event of events) {         
          if ($(this).data('id') === event.id) {
            $(this).text('❤️');
            addToOffCanvas(event.id, $(this))
            break;
          }
        }
      } else {
        if ($(this).data('id') === events.id) {
          $(this).text('❤️');
          addToOffCanvas(events.id, $(this))
        }
      }
    });
  }

  async function reduxPage() {
    const response = await fetch('/saved_events/')
    const events = await response.json()
    return events;     
  }
}());


