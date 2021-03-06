date_format = event.all_day_event? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'

json.id event.id
json.title event.title
json.description event.description
json.booking_time event.booking_time
json.start event.start.strftime(date_format)
json.end event.end.strftime(date_format)

json.allDay event.all_day_event? ? true : false

json.update_url event_path(event, method: :patch)
json.edit_url edit_event_path(event)
