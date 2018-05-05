document.addEventListener("turbolinks:load", function() {
	$input = $("[data-behavior='autocomplete']")

	var options = {
		getValue: "email",
		url: function(phrase) {
			return "/search.json?q=" + phrase;
		},
		categories: [
			{
				listLocation: "users",
				header: "<strong>Users</strong>",
			}
		],
		list: {
			onChooseEvent: function() {
				var url = $input.getSelectedItemData().url
				console.log(url)
			}
		}
	}

	$input.easyAutocomplete(options)
});