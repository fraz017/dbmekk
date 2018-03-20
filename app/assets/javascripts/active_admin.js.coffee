#= require active_admin/base
#= require vendor/bootstrap.min
#= require moment
#= require fullcalendar
#= require full_calendar_admin
#= require mask

$(document).ready ->
  $('#event_license_no').mask 'AA-00000'
  $('#event_phone_number').mask '00000000'
  return