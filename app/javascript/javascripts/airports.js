document.addEventListener("turbolinks:load", function() {

  $input = $('*[data-behavior="autocomplete"]')

  var options = {
    url: function(phrase) {
      return "/search_apt.json?q=" + phrase;
    },
    getValue: "apt",
    list: { maxNumberOfElements: 20 }
  };

  $input.easyAutocomplete(options);

  $inputFull = $('*[data-behavior="autocomplete-full"]')

  var optionsFull = {
    url: function(phrase) {
      return "/full/search_apt.json?q=" + phrase;
    },
    getValue: "apt",
    list: { maxNumberOfElements: 20 },
    template: { 
    	type: 'links',
    	fields: {
    		link: 'link' }
    	}
  };

  $inputFull.easyAutocomplete(optionsFull);
});