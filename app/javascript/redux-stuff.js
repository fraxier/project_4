$(document).ready(async function() {
  const events = await getSavedEvents();
  store.dispatch(doLoadSavedEvents(events));

  const pledged = await getPledgedEvents();

  populatePledges();

  populateUI();

  function populatePledges() {
    $('.card-heart').each(function() {
      const pledge = pledged.find(pledge => pledge["event_id"] === $(this).data('id'))
      console.log(pledge)
      if (pledge !== undefined) {
        $(this).addClass('pledged');
        const sibling = $(this).next();
        sibling.removeClass('d-none').text(`$${pledge["amount"]} - Pledged!`)
      }
    });
  }

  $('.card-heart:not(.pledged)').click(handleHeartClick);

  function alertMe() {
    alert('OH MY GODO')
  }

  function handleHeartClick() {
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
        addToOffCanvasFromHeart(id, $(this))
      })
      .catch(error => console.log(error))
    }
  }

  function addToOffCanvasFromHeart(id, element) {
    // console.log('adding to canvas', id, element.data('name'), element.data('date'))

    const offCanvas = $('#offcanvasRight');
    new bootstrap.Offcanvas(offCanvas).show();
    
    const event = {id: id, name: element.data('name'), date: element.data('date')}
    store.dispatch(doAddEvent(event))

    if (store.getState().savedEvents.length > 0) {
      $('#checkout-btn').removeClass('d-none')
    }

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
    store.dispatch(doRemoveEvent(id))
    if (store.getState().savedEvents.length < 1) {
      $('#checkout-btn').addClass('d-none')
    }
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

  async function getSavedEvents() {
    const response = await fetch('/saved_events/')
    const events = await response.json()
    return events;     
  }

  async function getPledgedEvents() {
    const response = await fetch('/pledged_events/')
    console.log(response)
    const events = await response.json()
    console.log(events)
    return events;
  }
}());


