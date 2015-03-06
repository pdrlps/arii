$(function() {
	/***
	 ** New integration
	 ***/

	// Remote save new integration
	$('#new_integration').on('ajax:success', new_integration_save_meta);

	// Add agent to integration
	$('#new_save_agent_select').on('click', new_save_agent_select);
	$('#new_agent_select_list').on('keypress', function(e) {
		if (e.keyCode == 13) {
			new_save_agent_select(e);
		}
	});

	// Add template to integration
	$('#new_save_template_select').on('click', new_save_template_select);
	$('#new_template_select_list').on('keypress', function(e) {
		if (e.keyCode == 13) {
			new_template_agent_select(e);
		}
	});
	// Finalize integration save
	$('#new_integration_save_button').on('click', new_integration_save);

	/***
	 ** Edit integration
	 ***/

	// Remote save edited integration
	$('.edit_integration').on('ajax:success', save_edit_integration);

	// Remove agent from integration
	$('.remove_agent_integration').on('click', remove_agent_integration);

	// Remove template from integration
	$('.remove_template_integration').on('click', remove_template_integration);

	// Add agent to integration from edit
	$('#edit_save_agent_select').on('click', edit_save_agent_select);

	// Add template to integration from edit
	$('#edit_save_template_select').on('click', edit_save_template_select);

	/***
	 *
	 * Enable/Disable integrations handlers
	 *
	 ***/

	 $('.integration_toggle').on('change',update_integration_toggle);


	 // Play paused integration
	$('.integration_play').on('click', integration_play);

	// Pause active integration
	$('.integration_pause').on('click', integration_pause);


	// show integration details
	$('.integration_details_toggle').on('click', function(event) {
		event.preventDefault();
		$('#details_integration_' + $(this).data('id')).toggle('slow');
	})

});

/**
 * Pause integration handler
 * @param  {[type]} event [description]
 * @return {[type]}       [description]
 */
function update_integration_toggle(event) {
	event.preventDefault();
	if ($(this).is(':checked')) {
		$.getJSON('../integrations/' + $(this).data('id') + '/play', function(data) {
			if (data.status === 100) {
				$("#integration_details_" + data.id).removeClass('info-disabled').addClass('info-enabled');
			} else {
				$(this).prop('checked',false);
			}
		});
	} else {
	$.getJSON('../integrations/' + $(this).data('id') + '/pause', function(data) {
		if (data.status === 400) {
			$("#integration_details_" + data.id).removeClass('info-enabled').addClass('info-disabled');
		} else {
			$(this).prop('checked',true);
		}
	});
	}
	/*$.getJSON('../integrations/' + $(this).data('id') + '/pause', function(data) {
		if (data.status === 400) {
			$("#integration_details_" + data.id).removeClass('info-enabled').addClass('info-disabled');
			$('#integration_pause_' + data.id).remove();
			$('#integration_play_' + data.id).html('<a href="#" data-id="' +data.id + '" class="icon-play integration_play">&nbsp; </a>');
			$('#integration_play_' + data.id).attr('title','Enable ' + data.title);
			$('#integration_play_' + data.id).data('title','Enable ' + data.title);
			$('.integration_play').on('click', integration_play);
			$(document).foundation('reflow');
		}
	});*/
}

/**
 * Pause integration handler
 * @param  {[type]} event [description]
 * @return {[type]}       [description]
 */
function integration_pause(event) {
	event.preventDefault();
	$.getJSON('../integrations/' + $(this).data('id') + '/pause', function(data) {
		if (data.status === 400) {
			$("#integration_details_" + data.id).removeClass('info-enabled').addClass('info-disabled');
			$('#integration_pause_' + data.id).remove();
			$('#integration_play_' + data.id).html('<a href="#" data-id="' +data.id + '" class="icon-play integration_play">&nbsp; </a>');
			$('#integration_play_' + data.id).attr('title','Enable ' + data.title);
			$('#integration_play_' + data.id).data('title','Enable ' + data.title);
			$('.integration_play').on('click', integration_play);
			$(document).foundation('reflow');
		}
	});
}

/**
 * Play integration handler
 * @param  {[type]} event [description]
 * @return {[type]}       [description]
 */
function integration_play(event) {
	event.preventDefault();
	$.getJSON('../integrations/' + $(this).data('id') + '/play', function(data) {
		if (data.status === 100) {
			$("#integration_details_" + data.id).removeClass('info-disabled').addClass('info-enabled');

			$('#integration_play_' + data.id).html('<a href="../integrations/' + data.id + '/execute" class="icon-play integration_play" data-id="' +data.id + '">&nbsp; </a>').attr('title','Execute ' + data.title).removeClass('integration_play');
			$('<span class="has-tip tip-right radius action right" id="integration_pause_' +data.id + '" data-tooltip title="Disable integration"><a class="icon-pause integration_pause" href="#" data-id="' + data.id + '" >&nbsp; </a></span>').insertAfter($('#integration_play_' + data.id));
			$('.integration_pause').on('click', integration_pause);
			$(document).foundation('reflow');
		}
	});
}

/**
 * On new integration, add agent to integration from select.
 **/
function new_save_agent_select(event) {
	event.preventDefault();
	var selected = $('#new_agent_select_list').find(':selected').val();
	if (selected === '0') {
		// show new agent form
		//$('#new_agent_form').fadeIn(500);
		window.location = '../agents/new';
	} else {
		// load existing agent data
		$.getJSON('../agents/' + selected + '/get.json', function(data) {
			$('#new_select_agent').html('<h5 id="agent" data-id="' + data.id + '"><a href="../agents/' + data.id + '" target="_blank">Agent <strong>' + data.title + '</strong></a></h5><div class="row"><div class="small-11 medium-12 large-11 columns right"><span class="label secondary radius icon-publisher">' + data.publisher + '</span> <span class="label secondary radius icon-schedule">' + data.schedule + '</span></div></div>');
		});
	}

	set_step(3);
	show_down($('#new_select_template'));
	$('#new_template_select_list').focus();
}

/**
 * On new integration, add template to integration from select.
 **/
function new_save_template_select(event) {
	event.preventDefault();
	var selected = $('#new_template_select_list').find(':selected').val();
	if (selected === '0') {
		// show new agent form
		//$('#new_template_form').fadeIn(500);
		window.location = '../templates/new';
	} else {
		// load existing agent data
		$.getJSON('../templates/' + selected + '/get.json', function(data) {
			$('#new_select_template').html('<h5 id="template" data-id="' + data.id + '"><a href="../templates/' + data.id + '" target="_blank">Endpoint <strong>' + data.title + '</strong></a></h5><div class="row"><div class="small-11 medium-12 large-11 columns right"><span class="label secondary radius icon-publisher">' + data.publisher + '</span></div></div>');
		});
	}

	set_step(3);
	show_down($('#new_integration_save'));
}



/**
 * Save new integration complete.
 **/
function new_integration_save(event) {
	event.preventDefault();
	var data = {};
	data.agent = $('#agent').data('id');
	data.template = $('#template').data('id');
	data.id = $('#integration').data('id');
	$.post('../integrations/' + data.id + '/save.json', data, function(response) {
		window.location = '../integrations/' + data.id;
	});
}


/**
 *	Save new integration metadata (creates @integration on database).
 **/
function new_integration_save_meta(e, data, status, xhr) {
	if (status === 'success') {
		integration = JSON.parse(xhr.responseText);
		// replace form content with integration details.
		$("#new_integration").html('<h4 id="integration" data-id="' + integration.id + '">Integration <strong>' + integration.title + '</strong></h4>');
		// update step counter
		set_step(2);

	}
	// show agent select
	show_down($('#new_select_agent'));
	$('#new_agent_select_list').focus();
}

/**
 * Process server response from editing integration properties.
 **/
function save_edit_integration(e, data, status, xhr) {
	if (status === 'success') {
		$('.integration_save').val('Saved');
		$('.edit_integration :input').on('change', function() {
			$('.integration_save').val('Save');
		});
	}
}

/**
 *	Detach template from integration
 **/
function remove_template_integration(event) {
	event.preventDefault();
	var data = {};
	data.id = $('#integration').data('id');
	data.remove = true;
	data.template = $(this).data('id');
	$.post('../' + data.id + '/save.json', data, function(response) {
		window.location.reload();
	});
}
/**
 *	Detach agent from integration.
 **/
function remove_agent_integration(event) {
	event.preventDefault();
	var data = {};
	data.id = $('#integration').data('id');
	data.remove = true;
	data.agent = $(this).data('id');
	$.post('../' + data.id + '/save.json', data, function(response) {
		window.location.reload();
	});
}


/**
 * On edit, add template to integration from select.
 **/
function edit_save_template_select(event) {
	event.preventDefault();
	var selected = $('#edit_template_select_list').find(':selected').val();
	if (selected === '0') {
		// show new agent form
	} else {
		// load existing agent data
		var data = {};
		data.id = $('#integration').data('id');
		data.template = selected;
		$.post('../' + data.id + '/save.json', data, function(response) {
			window.location.reload();
		});
	}
}

/**
 * On edit, add agent to integration from select.
 **/
function edit_save_agent_select(event) {
	event.preventDefault();
	var selected = $('#edit_agent_select_list').find(':selected').val();
	if (selected === '0') {
		// show new agent form
	} else {
		// load existing agent data
		var data = {};
		data.id = $('#integration').data('id');
		data.agent = selected;
		$.post('../' + data.id + '/save.json', data, function(response) {
			window.location.reload();
		});
	}
}
/**
 *	Show stuff with fade in and slide down
 **/
function show_down(element) {
	element.removeClass('hidden').addClass('animated fadeIn');
}

/**
 *	Update step counter on new integration wizard.
 **/
function set_step(step) {
	$('#step').hide().html(' Step <strong>' + step + '</strong>').fadeIn(500);
}
