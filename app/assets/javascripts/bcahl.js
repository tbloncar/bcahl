jQuery(function($) {
	// fade flash message on 'x' click
	$('.flash-message-fade').click(function() {
		$('.flash-message').fadeOut('slow');
	});
	// autocomplete player selection
	$('#player_name').autocomplete({
		source: $('#player_name').data('autocomplete-source')
	});
	// autocomplete team selection
	$('#team_name').autocomplete({
		source: $('#team_name').data('autocomplete-source')
	});
	// tabs for season show page
	$('#season-tabs').tabs();
	// jquery masonry for photos
	$('.photos-container').masonry({
	  columnWidth: 280,
	  itemSelector: '.photo-container',
	  gutterWidth: 16
	});
});
