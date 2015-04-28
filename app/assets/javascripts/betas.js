$(function() {
    // Remote save new agent
    $('#new_betas').on('click', function() {
        $(this).val('Sending...');
    });
    $('#new_betas').on('ajax:success', new_beta_save);

    // Remote save edited agent
    $('.edit_betas').on('ajax:success', edit_beta_save);
});

/**
 *  Redirect on Alpha save.
 **/
function new_beta_save(e, data, status, xhr) {
    if (status === 'success') {
        // beta = JSON.parse(xhr.responseText);
        //window.location = '../betas/' + beta.id;
        height = $('#request_access_message').height();
        $('#request_access_message').animate({
            opacity: 0
        }, function(e) {
            $('#request_access_message').html('Thank you for you interest! We will get back to you shortly!').height(height).animate({
                opacity: 1
            });
            // remove modal after 3s
            setTimeout(function(e) {
                $('#request_access').foundation('reveal', 'close');
            }, 10000);
        });
    }
}

/**
 *  Redirect on Alpha edit.
 **/
function edit_beta_save(e, data, status, xhr) {
    if (status === 'success') {
        beta = JSON.parse(xhr.responseText);
        window.location = '../betas/' + beta.id;
    }
}