$(function() {
    /**
     * WIZARD
     */
    // manage inputs
    $('#integration_existing_input').on('click', function(event) {
        event.preventDefault();
        $('.integration_area').fadeOut();
        $('.output_area').fadeOut(); // hide stuff
        $('#integration_area_existing_input').fadeIn();
        $('#new_integration_next_input_button').fadeIn();


        // update styles
        $('#integration_panel_new_input').removeClass('info-enabled').removeClass('info-secondary').addClass('info-disabled');
        $('#integration_panel_existing_input').removeClass('info-disabled').removeClass('info-secondary').addClass('info-enabled');
    });

    $('#integration_new_input').on('click', function(event) {
        event.preventDefault();
        $('.integration_area').fadeOut();
        $('.output_area').fadeOut(); // hide stuff
        $('#integration_area_new_input').fadeIn();
        $('#new_integration_next_input_button').fadeOut();

        // update styles
        $('#integration_panel_existing_input').removeClass('info-enabled').removeClass('info-secondary').addClass('info-disabled');
        $('#integration_panel_new_input').removeClass('info-disabled').removeClass('info-secondary').addClass('info-enabled');
    });

    // manage outputs
    $('#integration_existing_output').on('click', function(event) {
        event.preventDefault();
        $('.output_area').fadeOut(); // hide stuff
        $('#integration_area_existing_output').fadeIn();

        // update styles
        $('#integration_panel_new_output').removeClass('info-enabled').removeClass('info-secondary').addClass('info-disabled');
        $('#integration_panel_existing_output').removeClass('info-disabled').removeClass('info-secondary').addClass('info-enabled');
    });

    $('#integration_new_output').on('click', function(event) {
        event.preventDefault();
        $('.output_area').fadeOut(); // hide stuff
        $('#integration_area_new_output').fadeIn();

        // update styles
        $('#integration_panel_existing_output').removeClass('info-enabled').removeClass('info-secondary').addClass('info-disabled');
        $('#integration_panel_new_output').removeClass('info-disabled').removeClass('info-secondary').addClass('info-enabled');
    });


    /***
     ** New integration
     ***/

    // Remote save new integration
    $('#new_integration').on('ajax:success', new_integration_save_meta);

    // Add input to integration
    $('#new_agent_select_list').on('change', existing_save_agent_select);
    $('#new_agent_select_list').on('keypress', function(e) {
        if (e.keyCode == 13) {
            existing_save_agent_select(e);
        }
    });
    $('#new_save_input').on('click', new_save_input);

    $('#new_save_output').on('click', new_save_output);

    // tab jumps
    $('#new_integration_next_input_button').on('click', function(event) {
        event.preventDefault();
        $('#tab_link_output').trigger('click');
        $('#tab_link_input').addClass('tab_complete').addClass('icon-check');
    });

    $('#new_integration_next_output_button').on('click', function(event) {
        event.preventDefault();
        $('#tab_link_review').trigger('click');
        $('#tab_link_output').addClass('tab_complete').addClass('icon-check');
    });



    // Edit integration
    $('.integration_save').on('click', save_integration_on_edit);

    // Add output to integration
    $('#new_template_select_list').on('change', existing_save_template_select);
    $('#new_template_select_list').on('keypress', function(e) {
        if (e.keyCode == 13) {
            existing_template_agent_select(e);
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

    // Enable/Disable integration
    $('.integration_toggle').on('change', update_integration_toggle);


    // show integration details
    $('.integration_details_toggle').on('click', function(event) {
        event.preventDefault();
        $('#details_integration_' + $(this).data('id')).toggle('slow');
    })

    // Joyride Tour
    $('#what_integration').on('click', function(event) {
        $(document).foundation({
            joyride: {
                template: {
                    button: '<a href="#" class="small button radius joyride-next-tip"></a>',
                    prev_button: '<a href="#" class="small button radius joyride-prev-tip"></a>',
                    wrapper: '<div class="joyride-content-wrapper radius"></div>',
                }
            }
        }).foundation('joyride', 'start');
    });

});


/**
 * Save on edit handler
 *
 */
function save_integration_on_edit(event) {
    event.preventDefault();
    var form;
    if ($('.edit_integration').exists()) {
        form = $('.edit_integration');
    } else if ($('#new_integration').exists()) {
        form = $('#new_integration');
    }
    form.submit();
}

/**
 * Enable/disable integration handler
 * @param  {[type]} event [description]
 * @return {[type]}       [description]
 */
function update_integration_toggle(event) {
    event.preventDefault();
    if ($(this).is(':checked')) {
        $.getJSON('../integrations/' + $(this).data('id') + '/enable', function(data) {
            if (data.status === 100) {
                $("#integration_details_" + data.id).removeClass('info-disabled').addClass('info-enabled');
            } else {
                $(this).prop('checked', false);
            }
        });
    } else {
        $.getJSON('../integrations/' + $(this).data('id') + '/disable', function(data) {
            if (data.status === 400) {
                $("#integration_details_" + data.id).removeClass('info-enabled').addClass('info-disabled');
            } else {
                $(this).prop('checked', true);
            }
        });
    }
}

/**
 * On new integration, add agent to integration from select.
 **/
function existing_save_agent_select(event) {
    event.preventDefault();

    var selected = $('#new_agent_select_list').find(':selected').val();

    // load existing agent data
    $.getJSON('../inputs/' + selected + '/get.json', function(data) {
        var html = '<div class="small-3 columns">&nbsp;</div><div class="small-9 columns"><h5 id="input" data-id="' + data.id + '"><a href="../inputs/' + data.id + '" target="_blank">' + data.title + '</a></h5><span class="label secondary radius icon-publisher">' + data.publisher + '</span> <span class="label secondary radius icon-schedule">' + data.schedule + '</span><br /><ul class="inline-list"><li><strong>Selectors: </strong></li>';
        var selectors = eval(data.payload.selectors);
        $.each(selectors, function(i) {
            var selector = eval(selectors[i]);
            $.each(selector, function(k, v) {
                html += '<li>' + k + '</li>';
            })
        });
        html += '</ul></div>';

        // update small with selected
        $('#existing_input_load').html(html);

        // update review tab
        var review = '<div id="input_details_' + data.id + '" class="row agent-info info-secondary"><div class="small-12 medium-6 large-6 columns"><h6 class="subheader">' + data.title + '</h6></div><div class="small-3 columns"><span class="label secondary radius icon-publisher">' + data.publisher + '</span> <span class="label secondary radius icon-schedule icon-' + data.schedule + '">' + data.schedule + '</span></div><div class="small-3 columns"><ul class="button-group radius right"><li><a href="../inputs/' + data.id + '" class="small button secondary icon-view">View</a></li><li><a href="../inputs/' + data.id + '/edit" class="small button secondary icon-edit">Edit</a></li></ul></div></div>';
        if (data.schedule === 'local') {
            review += '<br/><div class="row"><div class="small-12 columns"><div data-alert class="alert-box warning radius"><i class="icon-warning"></i>You have configured an input for local execution, <a href="#" data-reveal-id="install_local">check the setup instructions for a full explanation on how to do this</a>.</div></div></div>'
        }
        $(document).foundation('reveal', 'reflow');
        $('#review_input').html(review);
        $('#existing_input_load').fadeIn();
    });

    // update UI
    $('#new_integration_next_input').fadeIn();

    show_down($('#new_select_template'));
}

/*
 * Submit new input creation form.
 */
function new_save_input(event) {
    event.preventDefault();
    $('#new_agent').submit();
}

function new_save_output(event) {
    event.preventDefault();
    $('#new_template').submit();
}

/**
 * On new integration, add template to integration from select.
 **/
function existing_save_template_select(event) {
    event.preventDefault();
    var selected = $('#new_template_select_list').find(':selected').val();
    if (selected === '0') {
        // show new agent form
        //$('#new_template_form').fadeIn(500);
        window.location = '../outputs/new';
    } else {
        // load existing agent data
        $.getJSON('../outputs/' + selected + '/get.json', function(data) {
            var html = '<div class="small-3 columns">&nbsp;</div><div class="small-9 columns"><h5 id="output" data-id="' + data.id + '"><a href="../templates/' + data.id + '" target="_blank">' + data.title + '</a></h5><span class="label secondary radius icon-endpoint">' + data.publisher + '</span></div>';
            $('#existing_output_load').html(html);


            // update review tab
            var review = '<div id="input_details_' + data.id + '" class="row agent-info info-secondary"><div class="small-12 medium-6 large-6 columns"><h6 class="subheader">' + data.title + '</h6></div><div class="small-3 columns"><span class="label secondary radius icon-endpoint">' + data.endpoint + '</span></div><div class="small-3 columns"><ul class="button-group radius right"><li><a href="../outputs/' + data.id + '" class="small button secondary icon-view">View</a></li><li><a href="../outputs/' + data.id + '/edit" class="small button secondary icon-edit">Edit</a></li></ul></div></div>';
            $('#review_output').html(review);
        });
    }

    // update UI
    $('#new_integration_next_output').fadeIn();
    show_down($('#new_integration_save'));
}



/**
 * Save new integration complete.
 **/
function new_integration_save(event) {
    event.preventDefault();
    var data = {};
    data.agent = $('#input').data('id');
    data.template = $('#output').data('id');
    data.id = $('#review_integration').data('id');
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
        $("#review_integration").html(integration.title);
        $("#review_integration").data('id', integration.id);
        $("#review_integration_description").html(integration.description);

        $('#tab_link_input').trigger('click');
        $('#tab_link_details').removeClass('icon-details').addClass('tab_complete').addClass('icon-check');

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
        // show overlay
        $('#overlayed').fadeIn('fast');

        // highlight button
        $('.integration_save').css('z-index', '10000').html('Saved');

        // hide overlay
        setTimeout(function() {
            $('#overlayed').fadeOut('fast')
        }, '500');


        $('.edit_integration :input').on('change', function() {
            $('.integration_save').html('Save');
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