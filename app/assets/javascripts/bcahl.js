jQuery(function($) {
	// fade flash message on 'x' click
	$('.flash-message-fade').click(function() {
		$('.flash-message').fadeOut('slow');
	})
	// autocomplete player selection
	$('#membership_player_id').autocomplete({
		source: $('#membership_player_id').data('autocomplete-source')
	})
});
