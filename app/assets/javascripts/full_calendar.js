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
      locale: 'nb',
      viewRender: function(currentView){
        var minDate = moment(),
        maxDate = moment().add(10,'weeks');
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
        content: "bestilt",
        trigger: 'hover',
        placement: 'top'
      });
      element.find('.fc-title').html("bestilt");
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
        if (getEventsByTime( start, end ).length >= 5) {
          $('.calendar').fullCalendar('unselect');
          alert("Slots full!");
          return false;
        }
        else if (moment().diff(start, 'days') > 0) {
          $('.calendar').fullCalendar('unselect');
          return false;
        }
        else{
          $.getScript('/events/new', function() {
            // $('#event_date_range').val(moment(start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(end).format("MM/DD/YYYY HH:mm"))
            // date_range_picker();
            $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
            $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
          });

          calendar.fullCalendar('unselect');
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
