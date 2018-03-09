var initialize_calendar;
initialize_calendar = function() {
  $('.calendar').each(function(){
    var calendar = $(this);
    calendar.fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: ''
      },
      handleWindowResize: true,
      weekends: false,
      defaultView: 'month',
      selectable: true,
      selectHelper: true,
      eventLimit: 5,
      events: '/events.json',
      editable: false,
      eventLimitText: "Something",
      viewRender: function(currentView){
        var minDate = moment(),
        maxDate = moment().add(3,'weeks');
        // Past
        if (minDate >= currentView.start && minDate <= currentView.end) {
          $(".fc-prev-button").prop('disabled', true); 
          $(".fc-prev-button").addClass('fc-state-disabled'); 
        }
        else {
          $(".fc-prev-button").removeClass('fc-state-disabled'); 
          $(".fc-prev-button").prop('disabled', false); 
        }
        // Future
        if (maxDate >= currentView.start && maxDate <= currentView.end) {
          $(".fc-next-button").prop('disabled', true); 
          $(".fc-next-button").addClass('fc-state-disabled'); 
        } else {
          $(".fc-next-button").removeClass('fc-state-disabled'); 
          $(".fc-next-button").prop('disabled', false); 
        }
      },
    eventRender: function(event, element) {
      element.popover({
          animation:true,
          delay: 300,
          content: event.license_no,
          trigger: 'hover',
          placement: 'top'
      });
      var ntoday = new Date().getTime();
      var eventEnd = moment( event.end ).valueOf();
      var eventStart = moment( event.start ).valueOf();
      if (!event.end){
        if (eventStart < ntoday){
          element.addClass("past-event");
          element.children().addClass("past-event");
        }
      } else {
        if (eventEnd < ntoday){
          element.addClass("past-event");
          element.children().addClass("past-event");
        }
      }
      if ( event.allDay === true ) {
        element.addClass("allday-event");
        element.children().addClass("allday-event");
      }
    },
      select: function(start, end) {
        if (moment().diff(start, 'days') > 0) {
          $('.calendar').fullCalendar('unselect');
          alert("Please select current or future dates!");
          return false;
        }
        else{
          window.location.href = "/admin/bookings/new?start="+moment(start).format('YYYY-MM-DD HH:mm')+"&end="+moment(end).format('YYYY-MM-DD HH:mm');
        }
      },

      eventDrop: function(event, delta, revertFunc) {
        event_data = { 
          event: {
            id: event.id,
            start: event.start.format(),
            end: event.end.format()
          }
        };
        $.ajax({
            url: event.update_url,
            data: event_data,
            type: 'PATCH'
        });
      },
      
      eventClick: function(event, jsEvent, view) {
        console.log(event);
        $('#modalTitle').html(event.title);
        $('#modalBody').html(event.description);
        $('#fullCalModal').modal();
      }
    });
  })
};
function getEventsByTime( start, stop ) {
    var todaysEvents = $('.calendar').fullCalendar('clientEvents', function(event) {

       return ( 
           ( event.start >= start && event.end <= stop )
       );
    });
    return todaysEvents;
}
$(document).on('ready', function(){
  initialize_calendar();
});
