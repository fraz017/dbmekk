var initialize_calendar;
initialize_calendar = function() {
  $('.calendar').each(function(){
    var calendar = $(this);
    calendar.fullCalendar({
      header: {
        left: 'next,prev, today',
        center: 'title',
        right: ''
      },
      height: 700,
      handleWindowResize: true,
      weekends: false,
      defaultView: 'month',
      selectable: true,
      selectHelper: true,
      eventLimit: 5,
      events: '/events.json',
      editable: false,
      eventLimitText: "Something",
      locale: 'nb',
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
      element.find('.fc-title').css("font-size", "12px").append(' - <span style="font-size: 12px">'+event.license_no+'</span> (<span style="font-size: 12px">'+event.booking_time+'</span>)');
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
        window.location.href = '/admin/bookings/'+ event.id +'/edit';
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
