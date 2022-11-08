$(document).ready(() => {
  // on page load turn all saved_events hearts to red

  refreshHearts();

  $('.card-heart').click(handleHeartClick);

  function handleHeartClick() {
    $(this).off('click', handleHeartClick);

    // if already saved then remove else add to saved_events cookie + add to offcanvas
    const id = $(this).data('id').toString();
    const name = $(this).data('name')
    const date = $(this).data('date')

    const eventCookie = findCookie('saved_events');
    const events = parseEventCookie(eventCookie);
    const index = events.indexOf(id)

    if (index > -1) {
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
        addToOffCanvas(id, name, date)
      })
      .catch(error => console.log(error))
    }

    $(this).on('click', handleHeartClick);
  }

  function addToOffCanvas(id, name, date) {
    console.log('adding to canvas', id, name, date)
    $('#eventsList').append(`
      <li id='event-id-${id}'>
        ${name}
        <span class="badge rounded-pill text-bg-primary">${date}</span>
      </li>`
    );
  }

  function removeFromOffCanvas(id) {
    $(`#event-id-${id}`).remove()
  }

  function refreshHearts() {
    $('.card-heart').each(function() {
      const eventCookie = findCookie('saved_events');
      const events = parseEventCookie(eventCookie);
      
      for (const event_id of events) {
        if ($(this).data('id').toString() === event_id) {
          $(this).text('❤️');
          break;
        }
      }
    });
  }

  function parseEventCookie(cookie) {
    return cookie.split('=')[1].split('&')
  }

  function findCookie(start) {
    const cookies = document.cookie.split(' ');
    return cookies.filter(cookie => {
      if (cookie.startsWith(start)) {
        return true;
      }
    })[0];
  }
});