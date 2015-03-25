$(function() {
    // Remote save new agent
    $('#new_client').on('ajax:success', new_client_save);

    // Remote save edited agent
    $('.edit_client').on('ajax:success', edit_client_save);
});

/**
 *  Redirect on client save.
 **/
function new_client_save(e, data, status, xhr) {
    if (status === 'success') {
        $('#client_message').animate({
            opacity: 0
        }, function(e) {

            // update client message
            $('#client_message').html('Thank you! We will be in touch shortly.').animate({
                opacity: 1
            });

            // remove modal after 3s
            setTimeout(function(e) {
                $('#request_integration').foundation('reveal', 'close');
            }, 3000);
        });
    }
}

/**
 *  Redirect on client edit.
 **/
function edit_client_save(e, data, status, xhr) {
    if (status === 'success') {
        client = JSON.parse(xhr.responseText);
        window.location = '../clients/' + client.id;
    }
}