$(function() {
    // Remote save new agent
    $('#new_feedback').on('click', function() {
        $(this).val('Sending...');
    });
    $('#new_feedback').on('ajax:success', new_feedback_save);

    // Remote save edited agent
    $('.edit_feedback').on('ajax:success', edit_feedback_save);
});

/**
 *  Redirect on feedback save.
 **/
function new_feedback_save(e, data, status, xhr) {
    if (status === 'success') {
        height = $('#feedback_message').height();
        $('#feedback_message').animate({
            opacity: 0
        }, function(e) {
            $('#feedback_message').html('Thank you for your feedback! We will look into it and get back to you within the next 48 hours!').height(height).animate({
                opacity: 1
            });
            // remove modal after 3s
            setTimeout(function(e) {
                $('#give_feedback').foundation('reveal', 'close');
            }, 10000);
        });
    }
}

/**
 *  Redirect on feedback edit.
 **/
function edit_feedback_save(e, data, status, xhr) {
    if (status === 'success') {
        feedback = JSON.parse(xhr.responseText);
        window.location = '../feedbacks/' + feedback.id;
    }
}