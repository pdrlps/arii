$(function() {
    // Create input
    $('#create_input').on('click', create_input);

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
    $('.input_toggle').on('change', update_input_toggle);

    // Joyride Tour
    $('#what_input').on('click', function(event) {
        $(document).foundation({
            joyride: {
                template: {
                    button: '<a href="#" class="small button joyride-next-tip info radius"></a>',
                    prev_button: '<a href="#" class="small button joyride-prev-tip info radius"></a>'
                }
            }
        }).foundation('joyride', 'start');
    });

    // download local inputs
    $('#download_local_input').on('click', download_local_input)
});

/**
 * Download local input handler
 */
function download_local_input(event) {
    $('#install_local').foundation('reveal', 'open');
}

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
                $(this).prop('checked', false);
            }
        });
    } else {
        $.getJSON('../inputs/' + $(this).data('id') + '/disable', function(data) {
            if (data.status === 400) {
                $("#input_details_" + data.id).removeClass('info-enabled').addClass('info-disabled');
            } else {
                $(this).prop('checked', true);
            }
        });
    }
}

/**
 *	Redirect on agent edit.
 **/
function edit_agent_save(e, data, status, xhr) {
    if (status === 'success') {
        // show overlay
        $('#overlayed').fadeIn('fast');

        // highlight button
        $('#save_agent').css('z-index', '10000').html('Saved');

        // hide overlay
        setTimeout(function() {
            $('#overlayed').fadeOut('fast')
        }, '500');

        // add change handler
        $('.edit_agent :input').on('change', function() {
            $('#save_agent').html('Save');
        })
    }
}