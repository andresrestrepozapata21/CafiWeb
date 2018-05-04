# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
JQuery ->
	$('#user_email').autocomplete
		source: $('#user_email').data('autocomplete_source')