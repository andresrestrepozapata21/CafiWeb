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
				location.reload();
				var url = $input.getSelectedItemData().url
				$input.val("")
				Turbolinks.visit(url)
				location.reload();
			}
		}
	}

	$input.easyAutocomplete(options)
});