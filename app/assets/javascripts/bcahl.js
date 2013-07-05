jQuery(function($) {
	// fade flash message on 'x' click
	$('.flash-message-fade').click(function() {
		$('.flash-message').fadeOut('slow');
	})
	// autocomplete player selection
	$('#player_name').autocomplete({
		source: $('#player_name').data('autocomplete-source')
	})
});
