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

    if (events != null && events.find(event => event.id === id)) {
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
        addToOffCanvasFromHeart(id, $(this))
      })
      .catch(error => console.log(error))
    }

    $(this).on('click', handleHeartClick);
  }

  function addToOffCanvasFromHeart(id, element) {
    // console.log('adding to canvas', id, element.data('name'), element.data('date'))
    $('#eventsList').append(`
      <li id='event-id-${id}'>
        ${element.data('name')}
        <span class="badge rounded-pill text-bg-primary">${element.data('date')}</span>
      </li>`
    );
  }

  function addToOffCanvasFromEvent(id, name, date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    const formatDate = new Date(date);
    const dateString = `${months[formatDate.getMonth()]} ${formatDate.getDate()}`
    // console.log('adding to canvas', id, element.data('name'), element.data('date'))
    $('#eventsList').append(`
      <li id='event-id-${id}'>
        ${name}
        <span class="badge rounded-pill text-bg-primary">${dateString}</span>
      </li>`
    );
  }

  function removeFromOffCanvas(id) {
    $(`#event-id-${id}`).remove()
  }
    
  function populateUI() {
    const events = store.getState().savedEvents
    const cards = $('.card-heart')
    if (events != null) {
      for(const event of events) {
        cards.each(function() {
          if ($(this).data('id') === event.id) {
            $(this).text('❤️');
          }
        });
        console.log(event)
        addToOffCanvasFromEvent(event.id, event.name, event.show_date)
      }
    }
  }

  async function reduxPage() {
    const response = await fetch('/saved_events/')
    const events = await response.json()
    return events;     
  }
}());


