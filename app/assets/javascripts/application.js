// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
// require turbolinks
//= require_tree .

if (typeof String.prototype.startsWith != 'function') {
    String.prototype.startsWith = function(str) {
        return this.slice(0, str.length) == str;
    };
}

if (typeof String.prototype.endsWith != 'function') {
    String.prototype.endsWith = function(str) {
        return this.slice(-str.length) == str;
    };
}
if (typeof String.prototype.addSlashes != 'function') {
    String.prototype.addSlashes = function() {
        return this;
    }
}

jQuery.fn.exists = function() {
    return this.length > 0;
}

$(function() {
    var $root = $('html, body');
    $(document).foundation();
    update_sidebar();

    // API KEY MANAGEMENT
    update_user_remove_key_selectors();

    //temp for user adding keys
    $('#user_add_api_key').on('click', update_user_generate_key);


    /**
     *  Files
     */

    // Joyride Tour
    $('#what_files').on('click', function(event) {
        $(document).foundation({
            joyride: {
                template: {
                    button: '<a href="#" class="small button joyride-next-tip info radius"></a>',
                    prev_button: '<a href="#" class="small button joyride-prev-tip info radius"></a>'
                }
            }
        }).foundation('joyride', 'start');
    });

    /**
     * Events
     */

    // redirect on inputs filter change
    $('#inputs_filter').on('change', function(event) {
        event.preventDefault();
        window.location = '/events/input/' + $(this).val();
    })

    // redirect on integrations filter change
    $('#integrations_filter').on('change', function(event) {
        event.preventDefault();
        window.location = '/events/integration/' + $(this).val();
    })


    /**
     * Inputs
     */
    /**
     * WIZARD
     */

    // manage input types
    $('#input_local').on('click', function(event) {
        event.preventDefault();
        $('.input_area').fadeOut(); // hide stuff
        $('#input_area_publisher').fadeIn();
        $('#publisher_content').fadeIn();

        // update styles
        $('#input_panel_cloud').removeClass('info-enabled').removeClass('info-secondary').addClass('info-disabled');
        $('#input_panel_local').removeClass('info-disabled').removeClass('info-secondary').addClass('info-enabled');

        $('#new_input_progress').width('25%'); // update progress bar

        // update and set schedule
        $('#agent_schedule').append('<option value="push">Push</option>').val('push');
    });

    $('#input_cloud').on('click', function(event) {
        event.preventDefault();

        // update schedule list (if changed)
        $("#agent_schedule option[value='push']").remove();
        $("#agent_schedule option[value='local']").remove();

        $('.input_area').fadeOut();
        $('#input_area_cloud').fadeIn();

        // update styles
        $('#input_panel_cloud').removeClass('info-disabled').removeClass('info-secondary').addClass('info-enabled');
        $('#input_panel_local').removeClass('info-enabled').removeClass('info-secondary').addClass('info-disabled');

        $('#new_input_progress').width('25%'); // update progress bar
    });

    //  manage cloud types

    $('#input_cloud_push').on('click', function(event) {
        event.preventDefault();
        $('#input_area_schedule').fadeOut('fast'); // hide schedule
        $('#input_area_publisher').fadeIn();
        $('#publisher_content').fadeIn();

        // update styles
        $('#input_panel_poll').removeClass('info-enabled').removeClass('info-secondary').addClass('info-disabled');
        $('#input_panel_push').removeClass('info-disabled').removeClass('info-secondary').addClass('info-enabled');

        $('#new_input_progress').width('50%'); // update progress bar

        // update and set schedule
        $('#agent_schedule').append('<option value="local">Local</option>').val('local');
    });

    $('#input_cloud_poll').on('click', function(event) {
        event.preventDefault();

        // update schedule list (if changed)
        $("#agent_schedule option[value='push']").remove();
        $("#agent_schedule option[value='local']").remove();

        $('#input_area_schedule').fadeIn();
        $('#input_area_publisher').fadeIn();
        $('#publisher_content').fadeIn();

        // update styles
        $('#input_panel_poll').removeClass('info-disabled').removeClass('info-secondary').addClass('info-enabled');
        $('#input_panel_push').removeClass('info-enabled').removeClass('info-secondary').addClass('info-disabled');

        $('#new_input_progress').width('50%'); // update progress bar
    });

    // update progress on cache
    $('#agent_payload_cache').on('change', function(event) {
        $('#new_input_progress').width('90%'); // update progress bar
    });

    /**
     * Lifebuoy
     */
    $('#lifebuoy').on('click', function(event) {
        event.preventDefault();
        $('.lifebuoy').toggle('fast');
    })

});

/**
 * Assign active class to correct menu item on dashboard
 * @return {[type]} [description]
 */
function update_sidebar() {

    menu_items = ['integrations', 'inputs', 'outputs', 'dashboard', 'files', 'library', 'user', 'events', 'docs', 'how', 'faq'];
    menu_items.forEach(function(entry) {
        if (window.location.href.indexOf(entry) > 0) {
            $('#sidebar_' + entry).addClass('active');
        }
    })
}

/**
 *	Add User API keys (no reload!).
 *
 **/
function update_user_generate_key(event) {
    event.preventDefault();

    $.post('../fluxcapacitor/generate_key.json', function(response) {
        if (response.status === 100) {
            $('#api_keys').append('<li id="user_api_key_' + response.access_token + '"><a href="../fluxcapacitor/generate_client.json?access_token=' + response.access_token + '" class="has-tip icon-download" title="Download sample client" target="_blank" data-tooltip></a> ' + response.access_token + ' <a href="#" title="Remove API key" data-tooltip class="has-tip remove icon-trash user_remove_api_key" data-id="' + response.access_token + '"></a></li>')
            update_user_remove_key_selectors();
        } else {
            alert('[ARiiP] unable to generate new API key.')
        }
    });

}


/**
 *	Remove User API keys (no reload!).
 *
 **/
function update_user_remove_key_selectors() {
    $('.user_remove_api_key').on('click', function(event) {
        event.preventDefault();
        var data = {};
        data.access_token = $(this).data('id');
        $.post('../fluxcapacitor/remove_key.json', data, function(response) {
            if (response.status === 100) {
                $('#user_api_key_' + response.access_token).remove();
            }
        });
    });
}

/**
 *	Show stuff with fade in and slide down
 **/
function show_down(element) {
    element.removeClass('hidden').addClass('animated fadeIn');
}