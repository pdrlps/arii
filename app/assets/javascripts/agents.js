$(function() {
	// Create input
	$('#create_input').on('click', create_input);

	// Remote save new input
	$('#new_agent').on('ajax:success', new_agent_save);

	// Edit input
	$('.edit_save_agent').on('click', save_input_on_edit);

	// Remote save edited input
	$('.edit_agent').on('ajax:success', edit_agent_save);

	// show input details
	$('.input_details_toggle').on('click', function(event) {
		event.preventDefault();
		$('#details_input_' + $(this).data('id')).toggle('slow');
	})

	// Enable/Disable input
	$('.input_toggle').on('change',update_input_toggle);
});

/**
 * Create input handler
 *
 */
function create_input(event) {
	event.preventDefault();
	$('#new_agent').submit();
}

/**
 * Save on edit handler
 *
 */
function save_input_on_edit(event) {
	event.preventDefault();
	$('.edit_agent').submit();
}

/**
 * Enable/disable input handler
 * @param  {[type]} event [description]
 * @return {[type]}       [description]
 */
function update_input_toggle(event) {
	event.preventDefault();
	if ($(this).is(':checked')) {
		$.getJSON('../inputs/' + $(this).data('id') + '/enable', function(data) {
			if (data.status === 100) {
				$("#input_details_" + data.id).removeClass('info-disabled').addClass('info-enabled');
			} else {
				$(this).prop('checked',false);
			}
		});
	} else {
	$.getJSON('../inputs/' + $(this).data('id') + '/disable', function(data) {
		if (data.status === 400) {
			$("#input_details_" + data.id).removeClass('info-enabled').addClass('info-disabled');
		} else {
			$(this).prop('checked',true);
		}
	});
	}
}

/**
 *	Redirect on agent save.
 **/
function new_agent_save(e, data, status, xhr) {
	if (status === 'success') {
		agent = JSON.parse(xhr.responseText);
		window.location = '../inputs/' + agent.id;
	}
}

/**
 *	Redirect on agent edit.
 **/
function edit_agent_save(e, data, status, xhr) {
	if (status === 'success') {
		$('#save_agent').html('Saved');
		$('.edit_agent :input').on('change', function() {
			$('#save_agent').html('Save');
		})
	}

}