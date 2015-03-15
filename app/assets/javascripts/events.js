$(function() {
    // Remote save new agent
    $('#new_alpha').on('ajax:success', new_alpha_save);

    // Remote save edited agent
    $('.edit_alpha').on('ajax:success', edit_alpha_save);
});

/**
 *  Redirect on Alpha save.
 **/
function new_alpha_save(e, data, status, xhr) {
    if (status === 'success') {
       // alpha = JSON.parse(xhr.responseText);
        //window.location = '../alphas/' + alpha.id;
        height = $('#request_access_message').height();
        $('#request_access_message').animate({opacity:0}, function(e) {
            $('#request_access_message').html('Thank you! We will be in touch shortly!').height(height).animate({opacity:1});

        });
    }
}

/**
 *  Redirect on Alpha edit.
 **/
function edit_alpha_save(e, data, status, xhr) {
    if (status === 'success') {
        alpha = JSON.parse(xhr.responseText);
        window.location = '../alphas/' + alpha.id;
    }
}